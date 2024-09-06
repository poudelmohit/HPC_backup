#!/usr/bin/env python3




def extract_positions_from_even_lines(filename, positions):
    positions = [int(pos) for pos in positions]

    with open(filename, 'r') as file:
        lines = file.readlines()

        for i, line in enumerate(lines):
            if i %2 != 0: # Process only odd-numbered lines (which contain the nucleotide sequence; 0-based index)
                result = [line [pos] for pos in positions if pos <= len(line)]
                print(" ".join(result))

# example_usage:
if __name__ == "__main__":
    filename = '483_65_S65_reformatted_aligned.fasta'
    positions = [1477, 1480, 1481, 1482, 1485, 1493, 1494, 1497, 1506, 1518, 1552, 1606, 1608, 1609, 1622, 1651, 1660, 1662, 1663, 1675, 1676, 1679, 1686, 1711, 1718, 1726, 1775, 1747, 1749, 1756, 1757, 1758, 1765, 1766, 1768, 1769, 1778, 1783, 1785, 1787, 1808, 1811, 1825, 1834]
    extract_positions_from_even_lines(filename, positions)