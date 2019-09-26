Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA50BEC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfIZGwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 02:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:53024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfIZGwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:52:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 801E8ABB3;
        Thu, 26 Sep 2019 06:52:44 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] riscv: move flush_icache_range/user_range() after flush_icache_all()
References: <20190926022938.58568-1-wangkefeng.wang@huawei.com>
X-Yow:  It's the RINSE CYCLE!!  They've ALL IGNORED the RINSE CYCLE!!
Date:   Thu, 26 Sep 2019 08:52:43 +0200
In-Reply-To: <20190926022938.58568-1-wangkefeng.wang@huawei.com> (Kefeng
        Wang's message of "Thu, 26 Sep 2019 10:29:38 +0800")
Message-ID: <mvm8sqb4khw.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/linux-riscv/mvm7e9spggv.fsf@suse.de/

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
