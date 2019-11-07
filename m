Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8EF3212
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 16:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfKGPIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 10:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388901AbfKGPIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:08:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09D4207FA;
        Thu,  7 Nov 2019 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573139317;
        bh=Rg+L5QcGbhilOqtTrRHcmJjwXMDVD7G6rIoeZ7YcNos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPHJT2BPRUtpterdm6jMAmBN/mUxCMbR4LwutLeeE0PfHH7F55sGGAgPGuKpvpipo
         IYBYoInqAG0VDczz6t7FgwTe6Cnu4Umr0cuMNgcTCkDx8NP7C5rpeo4PJtO0x8lRUz
         WvcqsbcW4AU9Tra/dgaA0msYNSElDC+BxSVpRFS0=
Date:   Thu, 7 Nov 2019 16:08:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Valery Ivanov <ivalery111@gmail.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: gasket_ioctl: Remove unnecessary
 line-breaks in funtion signature
Message-ID: <20191107150834.GA154681@kroah.com>
References: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 06:08:21PM +0000, Valery Ivanov wrote:
> 	This patch fix the function signature for trace_gasket_ioctl_page_table_data
> 	to avoid the checkpatch.pl warning:
> 
> 		CHECK: Lines should not end with a '('

Why the huge indentation?

THat's not ok, please fix up.

thanks,

greg k-h
