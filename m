Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE429331
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbfEXIe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389046AbfEXIe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:34:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFE920675;
        Fri, 24 May 2019 08:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558686866;
        bh=ob/7Sz9F0cKP9wKRpECJAF/PRJ5kcHembSLLMghwFj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4SkXufx0XuGi/3YT2UX2/sRKrsqXA5md8EF3ksMED1ZVQpm66Pk76b9nEWscOic/
         FUHCrZlGnzxW1PUQUrEhZRs5VyRVPmJcZqd1BydnwhrVR0/Gy/pP7ywHxbb4XtpiQ3
         7fOvq+JjYxUhY1TfcfCtCIqDelpCE1WgT5NaeXAo=
Date:   Fri, 24 May 2019 10:34:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: ks7010: Remove initialisation in
Message-ID: <20190524083423.GA18583@kroah.com>
References: <20190524080622.4801-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524080622.4801-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:36:22PM +0530, Nishka Dasgupta wrote:
> As the initial value of the return variable result is never used, it can
> be removed.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
> Changes in v2:
> - Clarified subject line

Your subject line is an incomplete sentence :(

