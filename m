Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E015D12761F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfLTHEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:04:46 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58640 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfLTHEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:04:46 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iiCL6-0008PG-MV; Fri, 20 Dec 2019 15:04:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iiCL1-0007oZ-Fl; Fri, 20 Dec 2019 15:04:39 +0800
Date:   Fri, 20 Dec 2019 15:04:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH v3 0/6] Add TEE interface support to AMD Secure
 Processor driver
Message-ID: <20191220070439.etvk73fedrijsrgm@gondor.apana.org.au>
References: <cover.1575438845.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575438845.git.Rijo-john.Thomas@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 11:48:57AM +0530, Rijo Thomas wrote:
> The goal of this patch series is to introduce TEE (Trusted Execution
> Environment) interface support to AMD Secure Processor driver. The
> TEE is a secure area of a processor which ensures that sensitive data
> is stored, processed and protected in an isolated and trusted
> environment. The Platform Security Processor (PSP) is a dedicated
> processor which provides TEE to enable HW platform security. It offers
> protection against software attacks generated in Rich Operating System
> (Rich OS) such as Linux running on x86.
> 
> Based on the platform feature support, the PSP is capable of supporting
> either SEV (Secure Encrypted Virtualization) and/or TEE. The first three
> patches in this series is about moving SEV specific functions and data
> structures from PSP device driver file to a dedicated SEV interface
> driver file. The last two patches add TEE interface support to AMD
> Secure Processor driver. This TEE interface will be used by AMD-TEE
> driver to submit command buffers for processing in PSP Trusted Execution
> Environment.
> 
> v3:
> * Rebased the patches onto cryptodev-2.6 tree with base commit
>   4ee812f6143d (crypto: vmx - Avoid weird build failures)
> 
> v2:
> * Rebased the patches on cryptodev-2.6 tree with base commit
>   d158367682cd (crypto: atmel - Fix selection of CRYPTO_AUTHENC)
> * Regenerated patch with correct diff-stat to show file rename
> * Used Co-developed-by: tag to give proper credit to co-author
> 
> Rijo Thomas (6):
>   crypto: ccp - rename psp-dev files to sev-dev
>   crypto: ccp - create a generic psp-dev file
>   crypto: ccp - move SEV vdata to a dedicated data structure
>   crypto: ccp - check whether PSP supports SEV or TEE before
>     initialization
>   crypto: ccp - add TEE support for Raven Ridge
>   crypto: ccp - provide in-kernel API to submit TEE commands
> 
>  drivers/crypto/ccp/Makefile  |    4 +-
>  drivers/crypto/ccp/psp-dev.c | 1033 ++++------------------------------------
>  drivers/crypto/ccp/psp-dev.h |   51 +-
>  drivers/crypto/ccp/sev-dev.c | 1068 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/crypto/ccp/sev-dev.h |   63 +++
>  drivers/crypto/ccp/sp-dev.h  |   17 +-
>  drivers/crypto/ccp/sp-pci.c  |   43 +-
>  drivers/crypto/ccp/tee-dev.c |  364 ++++++++++++++
>  drivers/crypto/ccp/tee-dev.h |  110 +++++
>  include/linux/psp-tee.h      |   73 +++
>  10 files changed, 1842 insertions(+), 984 deletions(-)
>  create mode 100644 drivers/crypto/ccp/sev-dev.c
>  create mode 100644 drivers/crypto/ccp/sev-dev.h
>  create mode 100644 drivers/crypto/ccp/tee-dev.c
>  create mode 100644 drivers/crypto/ccp/tee-dev.h
>  create mode 100644 include/linux/psp-tee.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
