Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1C17A8F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCEPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 10:36:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgCEPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sa62ga7pS4vAP4ElKjvnpA5qnFaP8zLHQg+/OzbUReM=; b=FuqAgmFgtSn9zh8NLcP9K3P3BK
        nw53oum4PKceQWqv7Xi7OomY96/vOdFw3NTF92o4Vh2Oi8Jx9RuTcKELu0Gw7E9oW3cUV3d6lUeRL
        wZkkqPX5SEa5RVR9hx9/9mAR58Bn2zBtLjBiNB7G49NPcsvu9mwDNf30ZDeAzEYM/CFjfrFeJxhSP
        OfahVmkVTxAfC6T70IvXFpKnzGg3Pm28+HPPcZX8IkpbGcZjuNLVgVAwHcsAqW4dwMhh2hrkVYAsy
        EpATotmD3baXPhe7eOcXGbH/BAqrQboRJwAWRKlDn/haSRU6YDdd5itwdbysOLeIImahCy7HBTOq/
        Fc+iAgOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9sY1-00076d-1S; Thu, 05 Mar 2020 15:36:29 +0000
Date:   Thu, 5 Mar 2020 07:36:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 2/2] dma-mapping: Fix dma_pgprot() for unencrypted
 coherent pages
Message-ID: <20200305153629.GA27051@infradead.org>
References: <20200304114527.3636-1-thomas_os@shipmail.org>
 <20200304114527.3636-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304114527.3636-3-thomas_os@shipmail.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

x86 maintainers: feel free to pick this up through your tree.
