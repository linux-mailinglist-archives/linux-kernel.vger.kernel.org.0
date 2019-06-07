Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E7386A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfFGI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 04:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfFGI5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:57:50 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1060208E3;
        Fri,  7 Jun 2019 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559897869;
        bh=GDQQkIPrp8fJsI5KojkhANtLnK4mw4SxKGgTPey7gwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWHBaSZifG1cQfkXr8gDeMR0NJAzbaUI+dY2nr/6PTBUl4SR4pbrcTL6MzgsR0j8j
         DUnT2KYRWnk+4Vpf2jMfe4cVrIlUAESlfuPi/HSomg8E1LMd+2RuScYWkCSV4ENFBk
         w+mjDmVxgK4aYyPD+f4EIixPt8ErWYRIGdpqgy6c=
Date:   Fri, 7 Jun 2019 10:57:46 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: module: Use struct_size() helper
Message-ID: <20190607085746.GA4211@linux-8ccs>
References: <20190606181853.GA29960@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190606181853.GA29960@embeddedor>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Gustavo A. R. Silva [06/06/19 13:18 -0500]:
>One of the more common cases of allocation size calculations is finding
>the size of a structure that has a zero-sized array at the end, along
>with memory for some number of elements for that array. For example:
>
>struct module_sect_attrs {
>	...
>        struct module_sect_attr attrs[0];
>};
>
>Make use of the struct_size() helper instead of an open-coded version
>in order to avoid any potential type mistakes.
>
>So, replace the following form:
>
>sizeof(*sect_attrs) + nloaded * sizeof(sect_attrs->attrs[0]
>
>with:
>
>struct_size(sect_attrs, attrs, nloaded)
>
>This code was detected with the help of Coccinelle.
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>---
>Changes in v2:
> - Update changelog text by adding a better description for
>   the motivation and usage of the struct_size() helper.

Applied. Thanks a lot!

Jessica

