Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2057387D11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436482AbfHIOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 10:45:36 -0400
Received: from verein.lst.de ([213.95.11.211]:55785 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIOpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:45:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 384BC68BFE; Fri,  9 Aug 2019 16:45:32 +0200 (CEST)
Date:   Fri, 9 Aug 2019 16:45:31 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        'Arnd Bergmann' <arnd@arndb.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'linux-ia64@vger.kernel.org'" <linux-ia64@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: remove sn2, hpsim and ia64 machvecs
Message-ID: <20190809144531.GA10398@lst.de>
References: <20190807133049.20893-1-hch@lst.de> <3908561D78D1C84285E8C5FCA982C28F7F41388B@ORSMSX115.amr.corp.intel.com> <3908561D78D1C84285E8C5FCA982C28F7F4143CB@ORSMSX115.amr.corp.intel.com> <20190807230737.GA11458@agluck-desk2.amr.corp.intel.com> <20190808065123.GA29146@lst.de> <20190808180129.GA18553@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808180129.GA18553@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:01:30AM -0700, Luck, Tony wrote:
> So most configs now build, and the generic one boots on my Tukwila system.
> 
> But a config based on arch/ia64/configs/zx1_defconfig gets a bunch
> of build errors from different files complaining about 'max_mapnr'
> 
> arch/ia64/mm/init.c:198:8: error: 'max_mapnr' undeclared (first use in this function) 
> ./include/linux/dma-mapping.h:359:6: error: 'max_mapnr' undeclared (first use in this function)
> kernel/dma/mapping.c:126:8: error: 'max_mapnr' undeclared (first use in this function)
> kernel/dma/mapping.c:181:8: error: 'max_mapnr' undeclared (first use in this function)
> mm/internal.h:393:8: error: 'max_mapnr' undeclared (first use in this function)

Looks like we somehow lost the indirect mm.h include for those builds,
I'll take a look at fixing this up.
