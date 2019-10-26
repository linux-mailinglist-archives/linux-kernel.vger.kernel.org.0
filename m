Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90DE58DD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfJZGoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 02:44:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJZGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 02:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aiPSd/BZaq8mZvPjuhE4XI65j8OE7xLRgVlrgYKV6X8=; b=F/jZojJuWlmtYwiabWSCN61UA
        DJTL0DKDCRX7BN+qAIbWIW+jalp4XIg7RqqpMFKWAIL/mWu2jghSkj2qPCYYZZVTynp1AhxZlzMEC
        5CEaqn3UkS8suk+1IHtm1KeugWS7ohi18uMi3TB0S0K3ZNPNhjoJ1Gm4ryl+MZGrz8gt2FoEI0OSM
        nCEY4LXt4xg21LC0vJk1U/1WBysEfj1A2GnytuxvgI++Gagou1GrLIdA1ILFw5rHWoVVLkycXCmiN
        V8HiJ0HsLPFP6ZVtquvpFwy1vmdAy8v/83zH4KWCrK7ER1LJoSDlG2R/9bTULsTpS2qWJ6BCIFVtn
        CDN4nubow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOFnR-0007qU-Gs; Sat, 26 Oct 2019 06:43:33 +0000
Date:   Fri, 25 Oct 2019 23:43:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Hildenbrand <david@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Allison Randal <allison@lohutok.net>,
        David Gibson <david@gibson.dropbear.id.au>, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/10] ocxl: Conditionally bind SCM devices to the
 generic OCXL driver
Message-ID: <20191026064333.GA24422@infradead.org>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-11-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025044721.16617-11-alastair@au1.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 03:47:05PM +1100, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch allows the user to bind OpenCAPI SCM devices to the generic OCXL
> driver.

This completely misses any explanation of why you'd want that.  The
what is rather obvious from the patch.

> +config OCXL_SCM_GENERIC
> +	bool "Treat OpenCAPI Storage Class Memory as a generic OpenCAPI device"
> +	default n

n is the default default.
