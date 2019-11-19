Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E27301028C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfKSQA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 11:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfKSQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:00:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF6A20730;
        Tue, 19 Nov 2019 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574179225;
        bh=mpZ1eVPdbpU3gDuboJ/Rps+9NEdYFQDjt91KhM3YLMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+fE/W1SQpo+mwDqOW/H8bwW+X+cSq4/01msXLWjznjEa/3WCmQzh92Af5AUW51Xd
         Pd9EyvEIJ3MdnzcHULlKxEnOPits80xBzv2DupQsqdaYMurA7pZAeq10rwAG0uUA4b
         G/VTLUKHadNlAAyb8FmxFe2DjxUMEd1ZP7pkz8fA=
Date:   Tue, 19 Nov 2019 17:00:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt change for v5.5 part 2
Message-ID: <20191119160022.GA2027670@kroah.com>
References: <20191119130751.GK11621@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119130751.GK11621@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 03:07:51PM +0200, Mika Westerberg wrote:
> Hi Greg,
> 
> There is one more Thunderbolt driver improvement that I would like to
> get into v5.5 merge window. Please consider pulling.

Hey, that sounds like the problem my laptop was having!  :)

Should this also go to stable for 5.4.y?

thanks,

greg k-h
