# The Next Generation of Wi-Fi Technology Beyond 802.11ax


## Abstract

Wi-Fi technology is continuously innovating to cater to the growing customer demands, driven by the digitalization of everything, in the home as well as in enterprise and hotspot spaces. In this article, we introduce to the wireless community the next generation Wi-Fi, based on IEEE 802.11be Extremely High Throughput (EHT), present the main objectives and timelines of this new 802.11be amendment, thoroughly describe its main candidate features and enhancements, and cover the important issue of coexistence with other wireless technologies. We also provide simulation results to assess the potential throughput gains brought by 802.11be with respect to 802.11ax.





## Objectives and Timeline

* Enabling new MAC and PHY modes of operation capable of supporting a maximum throughput of at least 30 Gb/s, measured at the MAC data service access point — 4x w.r.t. 802.11ax — using carrier frequencies between 1 and 7.125 GHz

* Ensuring backward compatibility and coexistence with legacy 802.11 devices in the 2.4,5, and 6 GHz unlicensed bands 



## Candidate Technical Features
### 320 MHz Bandwidth and More Efficient Utilization of Noncontiguous Spectrum
![](https://i.imgur.com/Ly3UQD7.png)
there are ongoing discussions on whether 802.11be-compliant APs should:

1.  Always schedule uplink transmissions in the 6GHz band, thereby reducing the time spent on channel contention
2.  Have the ability to request 802.11ax devices to vacate the 6 GHz band on demand, to reinforce such coordinated access



### Multi-Band/Multi-Channel Aggregation and Operation

* Multi-band data aggregation.
* Simultaneous transmission and reception in different bands/channels.
* Simultaneous transmission and reception in the same channel.
* Data and control plane separation.


### 16 Spatial Streams and Multiple-Input Multiple-Output Protocol Enhancements
further upgrade the APs’ spatial multiplexing capabilities to accommodate up to 16 spatial streams

implicit channel sounding procedure that relies on STA-transmitted pilots and exploits uplink/downlink channel reciprocity by calibration method

### Multi-Access Point Coordination

802.11be APs will permit more efficient utilization of the limited time, frequency, and spatial resources available, and thus is also an appealing approach to enhance system performance.

1. Coordinated OFDMA.

Coordinated OFDMA is particularly attractive to minimize the latency of
short packet data transmissions, since it allows efficient sharing and full occupation of the band by collaborating neighboring devices, which
otherwise would require multiple contention processes and not utilize the available resources to their full potential.

2. Coordinated Null Steering.

When compared to coordinated OFDMA, coordinated null steering generally requires a further degree of cooperation among overlapping BSSs
to organize scheduling decisions and facilitate the acquisition of CSI from non-associated devices, which is essential for the effective placement
of radiation nulls.

3. Distributed MIMO (D-MIMO).

the implementation of D-MIMO in 802.11be would require the design
of new distributed carrier sense multiple access with collision avoidance (CSMA/CA) mechanisms, compliant with regulations,to optimize channel
access and guarantee fair coexistence with independent APs deployed in the same coverage area.

![](https://i.imgur.com/Ft6Grnp.png)


### Enhanced Link Adaptation and Retransmission Protocol

802.11be should evolve toward hybrid ARQ (HARQ) capabilities.
HARQ-capable devices attempting to decode a retransmitted MPDU do not ignore the previous unsuccessful MPDU(s), but instead combine their soft-bits to improve the likelihood of correct decoding.

MAC protocol data units (MPDUs)
hybrid automatic repeat request (HARQ)


## Coexistence in the 6 GHz Band
1. Coordinated OFDMA.
2. Coordinated Null Steering.
3. Distributed MIMO (D-MIMO)

## 802.11be Performance Evaluation








