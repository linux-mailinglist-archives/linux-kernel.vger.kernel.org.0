Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185FCD397C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 08:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfJKGnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 02:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfJKGnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:43:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2B520650;
        Fri, 11 Oct 2019 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570776225;
        bh=tXOhKyYRMzD2hzw/SdifIbUDRJwUHCrYEYaiWmP8vQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uu1VhaorDPkEa8GWwA8biMt3VrQKNIcTxWJBxfHAKVG8Udq9FiGTgjcKxF3QJ1JCO
         zE9JEIiVguOsqlqTdk9fyxSuGcv8J7Pi5FYYTdiy1o64KvNMb+IxIMqqlEKnONIsSX
         ojphvoPefE+dtSEhfedKWLwJ7yjhanHmx0GJXWHg=
Date:   Fri, 11 Oct 2019 08:43:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: add support for the cc1101 RF transceiver chip
 from TI
Message-ID: <20191011064342.GA1045420@kroah.com>
References: <20190922060356.58763-1-hs@denx.de>
 <20190922060356.58763-3-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922060356.58763-3-hs@denx.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 08:03:56AM +0200, Heiko Schocher wrote:
> +struct __attribute__ ((packed)) msg_queue_user {
> +	int	type; /* CC1101_MSG_SET_ */
> +};
> +
> +/* CC1101_MSG_DEFINE_CONFIG */
> +struct __attribute__ ((packed)) config_param {
> +	char addr;
> +	char val;
> +};

{sigh}

None of these structures are valid ones to be passing to/from
userspace/kernel at all.  Please fix them up to work properly (i.e. use
the correct types and such).  I think there's a "how to write a correct
ioctl" document in the documentation directory somewhere, you might want
to search for that.

thanks,

greg k-h
