Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5638EFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfHOQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 12:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730298AbfHOQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:00:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437762089E;
        Thu, 15 Aug 2019 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565884831;
        bh=+/fnRC0jyLVx6w920S0CF2lCIeWd4yq3V09fV2AHnhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWmoVGtPoveLoyfnLs/9mqMq5pYFU9h2xV2OIfAV4B31zah4f7ieduiOuiGxClEdB
         IuGnVeeqH2/8bPzkxENWlpIiUjAXjy7jQkSUY0+2F15xz+0Mewxduj/DO1/eHI/bwa
         lgysM4yBfyo8Stj0WHD1DTOZkAPyXf53sKKzZy7c=
Date:   Thu, 15 Aug 2019 18:00:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 0/2] Add default binderfs devices
Message-ID: <20190815160029.GA23940@kroah.com>
References: <20190808222727.132744-1-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808222727.132744-1-hridya@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:27:24PM -0700, Hridya Valsaraju wrote:
> Binderfs was created to help provide private binder devices to
> containers in their own IPC namespace. Currently, every time a new binderfs
> instance is mounted, its private binder devices need to be created via
> IOCTL calls. This patch series eliminates the effort for creating
> the default binder devices for each binderfs instance by creating them
> automatically.
> 
> Hridya Valsaraju (2):
>   binder: Add default binder devices through binderfs when configured
>   binder: Validate the default binderfs device names.

I'd like to get a reviewed-by from the other binder maintainers before
taking this series....

{hint}

