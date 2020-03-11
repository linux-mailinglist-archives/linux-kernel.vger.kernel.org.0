Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF417181297
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 09:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgCKIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 04:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKIGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:06:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9742051A;
        Wed, 11 Mar 2020 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583914007;
        bh=wrkxLkNSJuSFWkXso1jggtLZ/EMJmTIF6RreW9CZSUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guynm0uwX1mGSSNdN3g22RSoCjQdqU9tFZRyO10WAeSyD1hJXe+2a28MTzu0iXswj
         4gJVMDMJ8s1vrwtTGemTvyUiC5jz+SzDSG5/0L/cRszH9kV8vfwUJdJ3D6pLIB3Ndq
         7oU59LQIiXk44ncO/P+rYnTR70f5QYcriceTRdog=
Date:   Wed, 11 Mar 2020 09:06:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drivers/base/cpu: s*nprintf() usage fixes /
 cleanups
Message-ID: <20200311080642.GA3662448@kroah.com>
References: <20200311080207.12046-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311080207.12046-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:02:05AM +0100, Takashi Iwai wrote:
> Hi,
> 
> this is a respin of my previous patch [*].
> Now the scnprintf() conversion is done only in the needed places,
> and the second patch cleans up the superfluous s*nprintf() usages.
> 
> Takashi
> 
> [*] https://lore.kernel.org/r/20200311071200.4024-1-tiwai@suse.de

Thanks for these, much nicer, I'll go queue them up now.

greg k-h
