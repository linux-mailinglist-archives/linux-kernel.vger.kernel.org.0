Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828DD3173F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfEaWfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 18:35:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40712 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfEaWfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:35:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id r136so8906677oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HNl3/v7jMscNyT+ygECdt6znSv+xKRYE9L5W9vgo8mg=;
        b=NXt0L9+igrAl2clGApEj/CKL2OEGjWrp2wc1h8SsFUhPmUICpFSyPBZm48X8oTqvmn
         P43uNxHoegJebehCr2XgncAbe1SwPFZneHqKIfhfbRVhtnPmUB7fP189favfgCucvU1b
         1ybBfMzny4qBKN0iJ5J2KnnQ+ZW7t987dUbti17qzcO7V62bzxvycLMzgKJsSvjHiGNq
         mSDIArmVNKJKaIKhv5n1gew1vOhIh/lw3WI8C1yC3YrZL57cnBMBpxdr8U+RBWb6oZ2g
         JZLXNZPy7kFnQMNNB4kKs9TcdMZjfc7nm9Va24aG96UuNqgoyWWp3XL6duH+f0hhJgrq
         wunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HNl3/v7jMscNyT+ygECdt6znSv+xKRYE9L5W9vgo8mg=;
        b=krKV2zH/SrH9NkTm4npAM4sIvUiR5x+UekOzfRWc51pIeT8bbPWaNg7gX/Ay9mGc1r
         JJDRyQg0y+scrtRlLvdP51IfyP7oWtfIMwKyHpIkjf8Cq+elyxe6KBlSShZW044tD/Ab
         0kGqdEMLkaaorJjaa5DdbLyYqPX+IE3vODG37oZeukY9tKUt0ARSTfjkvL/d0V0x7u7k
         jiTDVbtyrXOy916J+ljuF++OD9UZ8ANu2uH0jHC7ZbpUTfsgaecjH/4wQ0RUSGlC1tn3
         Vg7hJ/Yugr6TlZPWaO742umBT9r2lkWhF2zLX0Y1LQw/x5BAdPzy2dIx8S2OiIlbPtQ3
         1iKA==
X-Gm-Message-State: APjAAAWdC4FYuQYi/Qw13bj+VN0pzxub8oV3SM4Q1uOq1nCBmT02tUep
        LOlxH3XLjKpuf+MeFM2UGVn/sJcoV7zBPoqpWA==
X-Google-Smtp-Source: APXvYqwHR0HJtar0OvGPiwQXSL4Adg/ok4MFJQu4Zjkkwkms3a7AshVhXbLe+27XvV8AFKIeJmadXopklvm0R4F31M0=
X-Received: by 2002:a54:488d:: with SMTP id r13mr625348oic.32.1559342153011;
 Fri, 31 May 2019 15:35:53 -0700 (PDT)
MIME-Version: 1.0
From:   amit nagal <nagalamit.18@gmail.com>
Date:   Sat, 1 Jun 2019 04:05:39 +0530
Message-ID: <CABWb+VzkDbgE2kQrGjDBzu0qZkvd72MTSdRQTFDLAKgp90WEwQ@mail.gmail.com>
Subject: linux kernel page allocation failure and tuning of page reclaim procedure
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     amitnagal18@gmail.com, amit.nagal@utc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We are using Renesas RZ/A1 processor based custom target board . linux
kernel version is 4.9.123.

1) the platform is low memory platform having memory 64MB.

2)  we are doing around 45MB TCP data transfer from PC to target using
netcat utility .
On Target , a process receives data over socket and writes the data to
flash disk .

3) At the start of data transfer , we explicitly clear linux kernel
cached memory by  calling echo 3 > /proc/sys/vm/drop_caches

4) during TCP data transfer , we could see free -m showing "free"
getting dropped to almost 1MB and most of the memory appearing as
"cached"

# free -m
                                            total         used   free
   shared   buffers   cached
Mem:                                     57            56         1
      0            2           42
-/+ buffers/cache:                                  12        45
Swap:                                   0              0           0

5) sometimes , we observed kernel memory getting exhausted as page
allocation failure happens in kernel  with the backtrace as printed
 below in point 7 ):

6) we have certain questions as below :
a) how the kernel memory got exhausted ?is the kernel page reclaim
mechanism not executing at right time ?
since at the time of low memory conditions in kernel , even though the
free memory drops to 1MB
but there still cached memory available is 42mb and page reclaim
procedure should have triggered
which would have synced the cached pages to disk and used the same for
kernel page allocations

b) are there any parameters available within the linux memory
subsystem with which
the reclaim procedure can be monitored and  fine tuned ?

c) can  some amount of free memory be reserved so that linux kernel
does not caches it for page cache usage
and kernel can use it for its other required page allocation (
particularly gfp_atomic ) as needed above on behalf of netcat nc
process ?
can some tuning be done in linux memory subsystem eg by using
/proc/sys/vm/min_free_kbytes  to achieve this objective .

d) can we be provided with further clues on how to debug this issue
further for out of memory condition in kernel  ?

7) Backtrace:
# [  775.947949] nc.traditional: page allocation failure: order:0,
mode:0x2080020(GFP_ATOMIC)
[  775.956362] CPU: 0 PID: 1288 Comm: nc.traditional Tainted: G
   O    4.9.123-pic6-g31a13de-dirty #19
[  775.966085] Hardware name: Generic R7S72100 (Flattened Device Tree)
[  775.972501] [<c0109829>] (unwind_backtrace) from [<c010796f>]
(show_stack+0xb/0xc)
[  775.980118] [<c010796f>] (show_stack) from [<c0151de3>]
(warn_alloc+0x89/0xba)
[  775.987361] [<c0151de3>] (warn_alloc) from [<c0152043>]
(__alloc_pages_nodemask+0x1eb/0x634)
[  775.995790] [<c0152043>] (__alloc_pages_nodemask) from [<c0152523>]
(__alloc_page_frag+0x39/0xde)
[  776.004685] [<c0152523>] (__alloc_page_frag) from [<c03190f1>]
(__netdev_alloc_skb+0x51/0xb0)
[  776.013217] [<c03190f1>] (__netdev_alloc_skb) from [<c02c1b6f>]
(sh_eth_poll+0xbf/0x3c0)
[  776.021342] [<c02c1b6f>] (sh_eth_poll) from [<c031fd8f>]
(net_rx_action+0x77/0x170)
[  776.029051] [<c031fd8f>] (net_rx_action) from [<c011238f>]
(__do_softirq+0x107/0x160)
[  776.036896] [<c011238f>] (__do_softirq) from [<c0112589>]
(irq_exit+0x5d/0x80)
[  776.044165] [<c0112589>] (irq_exit) from [<c012f4db>]
(__handle_domain_irq+0x57/0x8c)
[  776.052007] [<c012f4db>] (__handle_domain_irq) from [<c01012e1>]
(gic_handle_irq+0x31/0x48)
[  776.060362] [<c01012e1>] (gic_handle_irq) from [<c0108025>]
(__irq_svc+0x65/0xac)
[  776.067835] Exception stack(0xc1cafd70 to 0xc1cafdb8)
[  776.072876] fd60: 0002751c c1dec6a0 0000000c 521c3be5
[  776.081042] fd80: 56feb08e f64823a6 ffb35f7b feab513d f9cb0643
0000056c c1caff10 ffffe000
[  776.089204] fda0: b1f49160 c1cafdc4 c180c677 c0234ace 200e0033 ffffffff
[  776.095816] [<c0108025>] (__irq_svc) from [<c0234ace>]
(__copy_to_user_std+0x7e/0x430)
[  776.103796] [<c0234ace>] (__copy_to_user_std) from [<c0241715>]
(copy_page_to_iter+0x105/0x250)
[  776.112503] [<c0241715>] (copy_page_to_iter) from [<c0319aeb>]
(skb_copy_datagram_iter+0xa3/0x108)
[  776.121469] [<c0319aeb>] (skb_copy_datagram_iter) from [<c03443a7>]
(tcp_recvmsg+0x3ab/0x5f4)
[  776.130045] [<c03443a7>] (tcp_recvmsg) from [<c035e249>]
(inet_recvmsg+0x21/0x2c)
[  776.137576] [<c035e249>] (inet_recvmsg) from [<c031009f>]
(sock_read_iter+0x51/0x6e)
[  776.145384] [<c031009f>] (sock_read_iter) from [<c017795d>]
(__vfs_read+0x97/0xb0)
[  776.152967] [<c017795d>] (__vfs_read) from [<c01781d9>] (vfs_read+0x51/0xb0)
[  776.159983] [<c01781d9>] (vfs_read) from [<c0178aab>] (SyS_read+0x27/0x52)
[  776.166837] [<c0178aab>] (SyS_read) from [<c0105261>]
(ret_fast_syscall+0x1/0x54)
[  776.174308] Mem-Info:
[  776.176650] active_anon:2037 inactive_anon:23 isolated_anon:0
[  776.176650]  active_file:2636 inactive_file:7391 isolated_file:32
[  776.176650]  unevictable:0 dirty:1366 writeback:1281 unstable:0
[  776.176650]  slab_reclaimable:719 slab_unreclaimable:724
[  776.176650]  mapped:1990 shmem:26 pagetables:159 bounce:0
[  776.176650]  free:373 free_pcp:6 free_cma:0
[  776.209062] Node 0 active_anon:8148kB inactive_anon:92kB
active_file:10544kB inactive_file:29564kB unevictable:0kB
isolated(anon):0kB isolated(file):128kB mapped:7960kB dirty:5464kB
writeback:5124kB shmem:104kB writeback_tmp:0kB unstable:0kB
pages_scanned:0 all_unreclaimable? no [  776.233602] Normal
free:1492kB min:964kB low:1204kB high:1444kB active_anon:8148kB
inactive_anon:92kB active_file:10544kB inactive_file:29564kB
unevictable:0kB writepending:10588kB present:65536kB
managed:59304kB mlocked:0kB slab_reclaimable:2876kB
slab_unreclaimable:2896kB kernel_stack:1152kB pagetables:636kB
bounce:0kB
free_pcp:24kB local_pcp:24kB free_cma:0kB [  776.265406]
lowmem_reserve[]: 0 0 [  776.268761] Normal: 7*4kB (H) 5*8kB (H)
7*16kB (H) 5*32kB (H) 6*64kB (H) 2*128kB (H) 2*256kB (H) 0*512kB
0*1024kB 0*2048kB 0*4096kB = 1492kB
10071 total pagecache pages
[  776.284124] 0 pages in swap cache
[  776.287446] Swap cache stats: add 0, delete 0, find 0/0 [
776.292645] Free swap  = 0kB [  776.295532] Total swap = 0kB
[  776.298421] 16384 pages RAM [  776.301224] 0 pages
HighMem/MovableOnly [  776.305052] 1558 pages reserved

Regards
Amit Nagal
