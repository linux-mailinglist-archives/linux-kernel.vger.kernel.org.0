Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C4AA139
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 13:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfIELXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 07:23:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731814AbfIELXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PrAw50ixKSQuGfujeGIi6zkEgaRXZ1hem0CBif3BOwI=; b=h2KbSChFt+NHR8R/SsqtQn1ea
        Itxe5U6Np40ihDXHVpk06bSo/RETQEFMI/p5R7NnjQxv/RZM2ZmmolWSeg36Z41RWNhHiUqxZc2n/
        2LkQde17hjTwGrNer3IjEarQGVFY4QRGzrg/3tPXNJMCjiv86MrmpvDCSkchB+coc9z3e9dhS7ZAz
        Ihsp2P5b3Fqn/NKE3pAJFTb8A/WAE2nOV5wXOmdKl0GNLBnixqqaZ1ur7RchrveGXC7ex12idgilv
        /rB7fURUdMCIy9EisfDLPs3Kv70phfgErDN+pw/vw1m1QjlYzLdeQpXgqEwGBG++tn7o2FNHiQNA3
        AbnDQvr8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5pr5-0003SW-8b; Thu, 05 Sep 2019 11:23:11 +0000
Date:   Thu, 5 Sep 2019 04:23:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        pv-drivers@vmware.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH 0/2] Fix SEV user-space mapping of unencrypted
 coherent memory
Message-ID: <20190905112311.GA10199@infradead.org>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905103541.4161-1-thomas_os@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks fine from the DMA POV.  I'll let the x86 guys comment on the
rest.
