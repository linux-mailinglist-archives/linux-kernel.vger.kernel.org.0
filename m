Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702B217DCFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCIKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 06:11:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIKL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:11:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6223FAFC6;
        Mon,  9 Mar 2020 10:11:54 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] RISC-V: Add kconfig option for QEMU virt machine
References: <20191125132147.97111-1-anup.patel@wdc.com>
        <20191125132147.97111-2-anup.patel@wdc.com>
X-Yow:  I'm working under the direct orders of WAYNE NEWTON to deport
 consenting adults!
Date:   Mon, 09 Mar 2020 11:11:53 +0100
In-Reply-To: <20191125132147.97111-2-anup.patel@wdc.com> (Anup Patel's message
        of "Mon, 25 Nov 2019 13:22:23 +0000")
Message-ID: <mvmh7yx4z2u.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: unmet direct dependencies detected for DRM_VIRTIO_GPU
  Depends on [m]: HAS_IOMEM [=y] && DRM [=m] && VIRTIO [=y] && MMU [=y]
  Selected by [y]:
  - SOC_VIRT [=y]

WARNING: unmet direct dependencies detected for NET_9P_VIRTIO
  Depends on [m]: NET [=y] && NET_9P [=m] && VIRTIO [=y]
  Selected by [y]:
  - SOC_VIRT [=y]

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
