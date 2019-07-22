Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB21F6FB4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 10:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfGVI3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 04:29:16 -0400
Received: from 8bytes.org ([81.169.241.247]:44708 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfGVI3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:29:16 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DA7572A9; Mon, 22 Jul 2019 10:29:14 +0200 (CEST)
Date:   Mon, 22 Jul 2019 10:29:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
Message-ID: <20190722082914.GA1524@8bytes.org>
References: <20190719184652.11391-1-joro@8bytes.org>
 <20190719184652.11391-4-joro@8bytes.org>
 <20190722081115.GH19068@suse.de>
 <alpine.DEB.2.21.1907221018460.1782@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907221018460.1782@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:19:32AM +0200, Thomas Gleixner wrote:
> On Mon, 22 Jul 2019, Joerg Roedel wrote:
> 
> > Srewed up the subject :(, it needs to be
> 
> Un-Srewed it :)

Thanks a lot :)
