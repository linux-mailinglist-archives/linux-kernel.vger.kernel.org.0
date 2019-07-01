Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E461415BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 07:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfEGF4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 01:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfEGF4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:56:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A92B7205ED;
        Tue,  7 May 2019 05:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557208571;
        bh=t1e6qR30XoBlOonZc+HmloDE9SesZNKua7dzCp++aG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cS1hFIOnRvtfqQN3aLt7ozfE6Nuiq9UTnTOQrVkeHauYc1jvYJAkxhbMj00JJ/kq8
         odLH6j1FQmphq7y78OZj13oyaZILigDagMpaWuM4iWulZY7DlG5US2/tuOgbrvKwiT
         99ZYJ1DTzPkw+U5sEkwJV99kJJSajOReiixmSaOo=
Date:   Tue, 7 May 2019 07:56:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 5/7] soundwire: add debugfs support
Message-ID: <20190507055608.GC17986@kroah.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-6-pierre-louis.bossart@linux.intel.com>
 <20190504070301.GD9770@kroah.com>
 <a9e1c3d2-fe29-1683-9253-b66034c62010@linux.intel.com>
 <20190506163810.GK3845@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506163810.GK3845@vkoul-mobl.Dlink>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 10:08:10PM +0530, Vinod Koul wrote:
> Yes, but then device exit routine is supposed to do debugfs cleanup as
> well, so that would ensure these references are dropped at that point of
> time. Greg should that not take care of it or we *should* always do
> refcounting.

Always do refcounting.  How else can you "guarantee" that it is safe?
