Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8D4EB3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFUOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:54:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C897720679;
        Fri, 21 Jun 2019 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561128887;
        bh=/1Ci+edbia4z7aEuuFoQgl2uGqQ4ASoXeFAvPttRzSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwf6YUqcXLMPMTkWXxxLFEjUWCn0Sm1UNgXS4V1Tq21w3Er/ISfMI6nGT6rTgO4o/
         UpNUGWDMh0ZGSAUkubEq+o0LU/cgVeR8HN0BR/MssvSejnHKehe1CrfKsdDVhyT74y
         uYHUSBjYpYyJoKgU+/Ksp3rM5ZmnQflpBPaKT2Nk=
Date:   Fri, 21 Jun 2019 16:54:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.5.0-30-g702c1b6c0e73
Message-ID: <20190621145444.GB6313@kroah.com>
References: <20190621142900.31988-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621142900.31988-1-robh@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 08:29:00AM -0600, Rob Herring wrote:
> Pull in SPDX tag conversion from upstream dtc. This will replace the
> conversion done in the kernel tree copy in v5.2-rc2.
> 
> This adds the following commits from upstream:
> 
> 702c1b6c0e73 README.license: Update to reflect SPDX tag usage
> 4097bbffcf1d dtc: Add GPLv2 SPDX tags to files missing license text
> 94f87cd5b7c5 libfdt: Add dual GPL/BSD SPDX tags to files missing license text
> c4ffc05574b1 tests: Replace license boilerplate with SPDX tags
> a5ac29baacd2 pylibfdt: Replace dual GPLv2/BSD license boilerplate with SPDX tags
> 7fb0f4db2eb7 libfdt: Replace GPL/BSD boilerplate/reference with SPDX tags
> acfe84f2c47e dtc: Replace GPLv2 boilerplate/reference with SPDX tags
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
