Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE76CA0BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfH1UjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 16:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfH1UjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:39:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5091920828;
        Wed, 28 Aug 2019 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567024754;
        bh=OlEZBKXBrpxUG4SiWKZI6c38Hh86eJ1mRnJbnj4iUuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cj44yD/RmQMkgDoJ/jo1ZSEj6FfNJw5yYo0vu2z79KsdCwc751kC32msiiL5Diwgu
         hRE0WS7EdOvQgH68uTSVn8Bd+r2bU/HtX98/RZ0v1nZEbYKJPwliCyX2f/cKKQMQxe
         7HQhn8GZcOrIYdZ+aLDKvWOjp5FhfBlZPyD9LlDQ=
Date:   Wed, 28 Aug 2019 22:39:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL drivers/misc] lkdtm updates for next
Message-ID: <20190828203912.GA21068@kroah.com>
References: <201908251522.DEAF618@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908251522.DEAF618@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 03:23:04PM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Please pull these LKDTM updates for next.
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:
> 
>   Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

Pulled and pushed out, thanks.

greg k-h
