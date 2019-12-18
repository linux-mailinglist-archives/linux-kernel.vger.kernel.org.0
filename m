Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0177F1241B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 09:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLRIaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 03:30:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfLRIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:30:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7234EAC52;
        Wed, 18 Dec 2019 08:30:20 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] define vmemmap before pfn_to_page calls
References: <20191217131530.513096-1-david.abdurachmanov@sifive.com>
X-Yow:  Yow!  Now we can become alcoholics!
Date:   Wed, 18 Dec 2019 09:30:19 +0100
In-Reply-To: <20191217131530.513096-1-david.abdurachmanov@sifive.com> (David
        Abdurachmanov's message of "Tue, 17 Dec 2019 15:15:28 +0200")
Message-ID: <mvm8sna5944.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 17 2019, David Abdurachmanov wrote:

> pfn_to_page call depends on `vmemmap` being available before the call.

Only if CONFIG_SPARSEMEM_VMEMMAP, as it seems.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
