import numpy as np
from typing import Dict, Any, List, Optional


def lteCRS(enb: Dict[str, Any]):
    """
    Generate CRS for all valid slots and OFDM symbols for the given cell for  subframes.
    """
    NCellID = enb["NCellID"]
    NDLRB = enb["NDLRB"]
    n_subframes = enb["NSubframe"]
    n_ports = enb["CellRefP"]
    crs_list = np.empty((n_subframes, 2, 2, 2 * NDLRB), dtype=np.csingle)
    for subframe in range(n_subframes):
        subframe_in_frame = subframe % 10
        N_s_base = subframe_in_frame * 2
        temp1 = crs_list
        for slot in [0, 1]:
            N_s = N_s_base + slot
            temp2 = temp1
            for L in [0, 4]:
                crs_seq = lte_generate_crs(N_s, L, NCellID, NDLRB)
                temp2[subframe][slot][L // 4] = crs_seq
            temp1 = temp2
        crs_list = temp1
    # print(crs_list)
    crs_column = np.reshape(crs_list, (-1, 1))
    crs_all_ports = np.tile(crs_column, (1, n_ports))
    # print(crs_all_ports.shape)
    return crs_all_ports


def lte_generate_crs(N_s: int, L: int, N_id_cell: int, NDLRB: int):
    N_cp = 1
    NDLRBmax = 110
    len_seq = 2 * NDLRB
    len_seq_max = 2 * NDLRBmax
    c_init = 1024 * (7 * (N_s + 1) + L + 1) * (2 * N_id_cell + 1) + 2 * N_id_cell + N_cp

    c = _generate_PRBS(c_init, 2 * len_seq_max)
    # c = np.arange(250)

    m_indices = np.arange(len_seq)
    m_prime = m_indices + (NDLRBmax - NDLRB)
    # c_used = c[2 * m_prime]
    c_used = np.take(c, 2 * m_prime)
    # c_used_imag = c[2 * m_prime + 1]
    c_used_imag = np.take(c, 2 * m_prime + 1)

    # left = (1 / np.sqrt(2)) * (1 - 2 * c_used)
    # rt = (1 / np.sqrt(2)) * (1 - 2 * c_used_imag)
    # print(left)
    # print(rt)
    r = (1 / np.sqrt(2)) * (1 - 2 * c_used) + 1j * (1 / np.sqrt(2)) * (
        1 - 2 * c_used_imag
    )
    # print(r)
    # print(r.shape)
    return r


def _calc_m_seq(N: int, c, taps, seq_len):

    # if seq_len is None:
    #     seq_len = 2**N - 1
    # m = np.zeros(seq_len, dtype=float)
    m = np.zeros(seq_len, "int32")
    # assert len(c) == N, "c has wrong length"
    m[:N] = c
    for i in np.arange(0, seq_len - N):
        m[i + N] = np.sum(np.take(m, i + taps)) % 2
    # print(m)
    return m


def _generate_PRBS(cinit: int, n: int):
    N = 31
    Nc = 1600
    seq_len = n + Nc

    # x1: m-sequence, x1(0)=1, x1(1:30)=0, taps [0,3]
    c_0 = np.zeros(N)
    c_0[0] = 1
    taps_0 = [0, 3]
    mseq_0 = _calc_m_seq(N, c_0, taps_0, seq_len)

    # x2: m-sequence, x2(0:30) = cinit bits, taps [0,1,2,3]
    c_1 = np.zeros(N)
    for i in range(N):
        c_1[i] = (cinit >> i) & 1
    taps_1 = [0, 1, 2, 3]
    mseq_1 = _calc_m_seq(N, c_1, taps_1, seq_len)
    # mseq_1 = np.zeros(seq_len, "int32")

    # Gold sequence: c(n) = (x1(n+Nc) + x2(n+Nc)) % 2
    gold_seq = np.add(mseq_0, mseq_1) % 2
    # print(gold_seq)
    seq = gold_seq[Nc : Nc + n].astype(int)
    # print(seq)
    return seq


enb = {"NCellID": 4, "NDLRB": 5, "NSubframe": 1, "CellRefP": 5}

print(lteCRS(enb))
