Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896F51930E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYTLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 15:11:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCYTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eNOTALyUtOBY7dFKg7mVMblKvoCIM5i+G8S+La4eSMw=; b=ibiOtYlIuHGK3LrkOOqcONPji7
        JQ7Q2RsQUVu7XQud7qG4+ldH8dCDWKwm5kYahoH/ClnObBCvL7Z6xvPREAj060Y1JLg4oCainXe+v
        AH4tg4U7SvlFo4VMh5DmodqrNl9XXYka4PbcHHTM/gOJfLOwX97azth/Y6WOWXERzjAXwCNc0Q9xG
        IPI5GqXUNWPcxWg6sQ2n9ifpnYW0F5ByU7M2KWXlcG0NfP/o46/9xyt5t5E+krzcfX7JjSqSDsAzT
        6ubm8sIQzcn3HutlBNsNjU9KcaZODBMW4iV8aXCiO9AZfm0e8pd1kse7UpShBnZIU0zU0E+Ox0IIR
        SQ8XrX1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHBQd-00032z-KO; Wed, 25 Mar 2020 19:11:03 +0000
Date:   Wed, 25 Mar 2020 12:11:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
Message-ID: <20200325191103.GA6495@infradead.org>
References: <20200325002847.2140-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325002847.2140-1-nbowler@draconx.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of comments:

No need for the "." the end of the subject line.

I also think you should just talk of the nvme_user_cmd function,
as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
is a nvme_user_cmd64 variant that needs the same fix, can you also
include that?

> +	if (in_compat_syscall()) {
> +		/*
> +		 * On real 32-bit kernels this implementation ignores the
> +		 * upper bits of address fields so we must replicate that
> +		 * behaviour in the compat case.

s/real //g please, there are no fake 32-vit kernels :)
