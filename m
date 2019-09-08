Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1769EACFD2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfIHQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 12:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfIHQpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:45:55 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C338221479;
        Sun,  8 Sep 2019 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567961155;
        bh=TLSx0eDVVIR9BUeNWztuRR5XMMb45dshPOmxd+txMxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUuEBmsIxz7gPIltGr0dKWkRGL8sQbJeLye44pKH2VyaYTozUwaU2hj89j4t85eqy
         orUE8bz3ZSvEGj4TK+uerA0IS6iwN5skalvteoeblB+iSPqf4R1h2CU0bfUVETvK0Q
         xWrFqypwXgivCnpSmny/qzefVHtJg6nejgvKW9G4=
Date:   Sun, 8 Sep 2019 17:45:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: exfat: drop duplicate date_time_t struct
Message-ID: <20190908164552.GD8362@kroah.com>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 04:10:13PM +0000, Valentin Vidic wrote:
> Use timestamp_t for everything and cleanup duplicate code.

You dropped function parameters in here, which you did not describe in
this changelog text :(

Please only try to do "one logical thing" per patch to make it easier to
review and revert if something goes wrong :)

thanks,

greg k-h
