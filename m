Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C156FACFCB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfIHQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 12:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfIHQln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:41:43 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DED3216C8;
        Sun,  8 Sep 2019 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567960903;
        bh=1Ubr+gGsLmIsNu1qigSSf3C36qMCG+gThIHB1/qjXbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0dR+fwzv+HiRlPvPZgpyPA/9b5tH876J4gao/qK5/G9jfAKCFDV9xRDvEZZWPZ43
         Pt/05+DarYy6Vb5ZzIr1VB/m0UqxzwATWgVnSDRxt+HZIe9nMhC2FKFNE8Vw1RY2fg
         aVkrufZcQvjLFwmmNjts6uCj1v7tKWS3HVdPpiIg=
Date:   Sun, 8 Sep 2019 17:41:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: exfat: drop unused field access_time_ms
Message-ID: <20190908164140.GB8362@kroah.com>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
 <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 04:10:14PM +0000, Valentin Vidic wrote:
> Not used in the exfat-fuse implementation and spec defines
> this position should hold the value for CreateUtcOffset.

Then why not just put CreateUtcOffset in here instaed of deleting it?

I would much rather the fields match the spec in the structures for lots
of good reasons, instead of having loads of "reserved[]" variables.

thanks,

greg k-h
