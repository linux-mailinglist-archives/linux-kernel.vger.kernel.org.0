Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC26F29165
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfEXG7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbfEXG7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:59:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3EC62175B;
        Fri, 24 May 2019 06:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558681147;
        bh=DJsZxsdJ5VMoeUdnAwjQRoPNoGPBg2DiyLHVBQ0oJHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoYzL2LQszVFzGkbCv3QHpyTyproCgBIiIh7tvOmNd/7rz+mQ4Wr/e5wA+qUsXkov
         9jUJwM9tWTR4+pAqgY7YsY74m9fbCMRL2JiF314PXDKgF3RG9S6dj6i+DJhl2aclPW
         sG8KlJpmqYJsW6FXtsQBs1HE/hLdynS944QsVRBI=
Date:   Fri, 24 May 2019 08:59:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Michael Straube <straube.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v4] staging: rtl8723bs: core: rtw_ap: fix Unneeded
 variable: "ret". Return "0
Message-ID: <20190524065905.GE3600@kroah.com>
References: <20190523181009.GA9411@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523181009.GA9411@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:40:09PM +0530, Hariprasad Kelam wrote:
> Function "rtw_sta_flush" always returns 0 value. So change
>  return type of rtw_sta_flush from int to void.

Odd line wrapping :(

Also your subject line is missing a trailing '"' character :(

v5?

thanks,

greg k-h
