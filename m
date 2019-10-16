Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E28D8A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391396AbfJPH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:59:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbfJPH7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:59:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 306C9AEA5;
        Wed, 16 Oct 2019 07:59:39 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     greentime.hu@sifive.com
Cc:     green.hu@gmail.com, paul.walmsley@sifive.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: fix virtual address overlapped in FIXADDR_START and VMEMMAP_START
References: <20191016073408.7299-1-greentime.hu@sifive.com>
X-Yow:  Oh, I get it!!  ``The BEACH goes on,'' huh, SONNY??
Date:   Wed, 16 Oct 2019 09:59:38 +0200
In-Reply-To: <20191016073408.7299-1-greentime.hu@sifive.com> (greentime hu's
        message of "Wed, 16 Oct 2019 15:34:08 +0800")
Message-ID: <mvmv9spdst1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 16 2019, greentime.hu@sifive.com wrote:

> From: Greentime Hu <greentime.hu@sifive.com>
>
> This patch fixes the virtual address layout in pgtable.h.
> The virtual address of FIXADDR_START and VMEMMAP_START should not be overlapped.
> These addresses will be existed at the same time in Linux kernel that they can't
> be overlapped.

s/be existed/exist/
s/be overlapped/overlap/

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
