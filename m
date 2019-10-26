Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490F9E5E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJZSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 14:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfJZSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:04:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B10620663;
        Sat, 26 Oct 2019 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113063;
        bh=RnQ7KzIlXLB02GaqoOUCoQODZ8K4G9ZrO4l3ZJNA05o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRDglpKhmshWqpZUFWyHziNgFaIvO7xlfyYjjTdLwINaKQW5oATwyC2hbVoN1lEky
         yH5+ZknWGF+sVk9JVlNRwINVoB2HV47KHIa4eQqNm99b9l//9X7c7vxgjQxWbIh1u1
         K4UhTFKPrcQ2jg+nO9aFHLUxFi03lSWpdd32+nFQ=
Date:   Sat, 26 Oct 2019 20:04:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RESEND PATCH 1/2] staging: rtl8712: Fix Alignment of open
 parenthesis
Message-ID: <20191026180421.GB645771@kroah.com>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
 <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:09:38PM -0300, Cristiane Naves wrote:
> Fix alignment should match open parenthesis.Issue found by checkpatch.

Space after a '.' between sentences, right?


thanks

greg k-h
