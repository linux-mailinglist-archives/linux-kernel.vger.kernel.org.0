Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9411A5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 09:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfLKISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 03:18:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLKISR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:18:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C69020652;
        Wed, 11 Dec 2019 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576052297;
        bh=AMX2uELmZXc9JMz1ZWkm2WGiRI+cSmDE7Gcp+CImNNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gz12lYuFWJWlmv5qypG1JMFKv9my/1gUc+04R83nktw3i8iKYDVVHkfAZL9OgFXsc
         ktan+5WFlUEOwKmyxBT7TKicY6RUxV+qYOuixSBhkdn8FD+13Uy8tOLQNYgh2y9bFp
         S34QlzAG0iwNWv+sH0I7yC3rrVD3691DySoIQdB4=
Date:   Wed, 11 Dec 2019 09:18:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon Schwartz <kern.simon@theschwartz.xyz>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Prevent overflow from causing infinite loops
Message-ID: <20191211081814.GA433262@kroah.com>
References: <2201ce63a2a171ffd2ed14e867875316efcf71db.camel@theschwartz.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2201ce63a2a171ffd2ed14e867875316efcf71db.camel@theschwartz.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:41:37PM -0500, Simon Schwartz wrote:
> num_resources in the platform_device struct is declared as a u32.
> The for loops that iterate over num_resources use an int as the counter,
> which can cause infinite loops on architectures with smaller ints.

What arch is that that has so many resources and yet is only a 32bit
system?

thanks,

greg k-h
