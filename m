Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE502471B9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 20:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfFOSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 14:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOSwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 14:52:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 619AF2184B;
        Sat, 15 Jun 2019 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560624724;
        bh=ZiyxNZ22/8DOyepnR7kpKn7cjCxVk7M7EDGwbpRg+to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXVijOEqPXod63gWGjwgnqNzXtTCmDh+lf+l8NWvk2ei0bYrDZ6uGnF99szd9YpB8
         J/TlFi3tLXWU4uuUlCci5RsVU1yuskt+w+5tKDmybNQS6dwCNDTleQQAPXvJe2ZKu4
         lbX/BXma7LFdNtS5cS+bqJw4ASnK3PyGy5kuPmZI=
Date:   Sat, 15 Jun 2019 20:52:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: android: fix style problem
Message-ID: <20190615185202.GA10201@kroah.com>
References: <20190615184605.GA7671@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615184605.GA7671@ahmlpt0706>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 12:16:05AM +0530, Saiyam Doshi wrote:
> checkpatch reported "WARNING: line over 80 characters".
> This patch fixes it by aligning function arguments.
> 
> Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
> ---
> Changes in v1:
> * Updated as per review comment. Now function arguments
>   uses two lines, one less line than previous submission.

It's really "v2", but that's fine :)

