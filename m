Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5110FDEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLCMnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:43:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y32EyG9QTIAAfBfEpUvYlhT+mcWXafYYc7fjM/sPObM=; b=m8Z9EA16p0cdhP5aXa2cDeouD
        8v18exxvbDL2VZ+g12YOFJL8h4D64m1aUWCjUztX9coGysKzDNmS82ECczmiSSugoSgZ9I8fL9733
        yByR1W4OgWm9Ji+79sSU19wUMIbaL9vhWILbJzqBWIYJTITSALTfX8PQqTR6ncq9isowfjM5tK81V
        DhgMGFKKI5B5HnMtJhJFcrzkzezv2TLmE+jL2cmZiZL0voqrqklRcOy//ON418iZSdT3QArUEvbuM
        ATlvjkn6wfb7OXS8n+w6/tzVdX7N06vOEiLtYT8y+Qz025I88HodvPHRaxMl+zkd3oThPgqxf9AOL
        VUr5RTx1g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic7Vo-0007i6-VW; Tue, 03 Dec 2019 12:42:40 +0000
Date:   Tue, 3 Dec 2019 04:42:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/27] Add support for OpenCAPI SCM devices
Message-ID: <20191203124240.GT20752@bombadil.infradead.org>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
 <20191203035057.GR20752@bombadil.infradead.org>
 <1e3892815b9684e3fb4f84bd1935ea7e68cd07d8.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3892815b9684e3fb4f84bd1935ea7e68cd07d8.camel@au1.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 03:01:17PM +1100, Alastair D'Silva wrote:
> On Mon, 2019-12-02 at 19:50 -0800, Matthew Wilcox wrote:
> > On Tue, Dec 03, 2019 at 02:46:28PM +1100, Alastair D'Silva wrote:
> > > This series adds support for OpenCAPI SCM devices, exposing
> > 
> > Could we _not_ introduce yet another term for persistent memory?
> > 
> 
> "Storage Class Memory" is an industry wide term, and is used repeatedly
> in the device specifications. It's not something that has been pulled
> out of thin air.

"Somebody else also wrote down Storage Class Memory".  Don't care.
Google gets 750k hits for Persistent Memory and 150k hits for
Storage Class Memory.  This term lost.

> The term is also already in use within the 'papr_scm' driver.

The acronym "SCM" is already in use.  Socket Control Messages go back
to early Unix (SCM_RIGHTS, SCM_CREDENTIALS, etc).  Really, you're just
making the case that IBM already uses the term SCM.  You should stop.
