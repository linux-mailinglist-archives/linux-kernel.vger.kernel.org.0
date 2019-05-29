Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D42D72C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfE2IAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 04:00:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfE2IAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:00:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22FE3AC23;
        Wed, 29 May 2019 08:00:36 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
References: <CAAhSdy3GqjS06QxCtY6OUkBZds4gygQsAkaoaa+sMj3z6qgUBQ@mail.gmail.com>
        <mhng-2b0ca072-2d6d-4422-96a2-2a4254255cc6@palmer-si-x1e>
X-Yow:  Gee, I feel kind of LIGHT in the head now, knowing I can't make
 my satellite dish PAYMENTS!
Date:   Wed, 29 May 2019 10:00:35 +0200
In-Reply-To: <mhng-2b0ca072-2d6d-4422-96a2-2a4254255cc6@palmer-si-x1e> (Palmer
        Dabbelt's message of "Tue, 28 May 2019 10:47:51 -0700 (PDT)")
Message-ID: <mvm8supd718.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 28 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> My only issue here is testing: IIRC last time we tried this it ended up causing
> trouble.

I've been running kernels with these settings since the beginning, and
never seen any trouble.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
