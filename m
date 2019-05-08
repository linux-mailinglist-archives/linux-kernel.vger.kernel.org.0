Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF918142
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfEHUn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:43:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfEHUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BhwXAbjkoDrvmRFXu3os3blWb466l8EQ11sVasbRwbU=; b=UlA96dIW25DYB4esae4s1EdfQ
        NEtuhMIw7nsyqaMR7A60rhAB+ErA7viMQ83cEbqqtrQUGsl2SdofRIkdWjPbxsjlKcafqZQX8oOp9
        JyOTUlhdlN4InWx7AQ1LHRmE2A7VTxnQBemIBNFozLO3BdjwJFoAP2lR7UPq9pqBnE3eSFXyzLPI5
        sQR3d5mP2y1GeT1guc0WKGdk8pQIrp5kEcTeM55UOxN9s1Nm57Rffxhv7tYtMzv2ZsFX9FGhOuFVf
        YCJHLeXvwBjFPn2vVAk5fvF+N+1UekWoWnxYF1/neLsPQXrYJaAt4kLQprc1LoAkGvLWBpADckL6u
        51bbcYViQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOTPu-0006ly-IJ; Wed, 08 May 2019 20:43:54 +0000
Subject: Re: linux-next: Tree for May 8
 (drivers/platform/x86/intel_pmc_core_plat_drv.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>
References: <20190508173403.6088d0db@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fa0e68b2-b839-b187-150c-13391c197b99@infradead.org>
Date:   Wed, 8 May 2019 13:43:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508173403.6088d0db@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/19 12:34 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190507:
> 
> The ubifs tree gained a conflict against Linus' tree.
> 

on i386 or x86_64:


  CC      drivers/platform/x86/intel_pmc_core_plat_drv.o
../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: warning: data definition has no type or storage class [enabled by default]
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
 ^
../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: error: type defaults to ‘int’ in declaration of ‘MODULE_DEVICE_TABLE’ [-Werror=implicit-int]
../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: warning: parameter names (without types) in function declaration [enabled by default]
../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: warning: data definition has no type or storage class [enabled by default]
 module_init(pmc_core_platform_init);
 ^
../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: error: type defaults to ‘int’ in declaration of ‘module_init’ [-Werror=implicit-int]
../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: warning: parameter names (without types) in function declaration [enabled by default]
../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: warning: data definition has no type or storage class [enabled by default]
 module_exit(pmc_core_platform_exit);
 ^
../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: error: type defaults to ‘int’ in declaration of ‘module_exit’ [-Werror=implicit-int]
../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: warning: parameter names (without types) in function declaration [enabled by default]
../drivers/platform/x86/intel_pmc_core_plat_drv.c:42:19: warning: ‘pmc_core_platform_init’ defined but not used [-Wunused-function]
 static int __init pmc_core_platform_init(void)
                   ^

and
WARNING: modpost: missing MODULE_LICENSE() in drivers/platform/x86/intel_pmc_core_plat_drv.o

-- 
~Randy
