Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED41C13ACD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgANPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbgANPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:00:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC6E222C4;
        Tue, 14 Jan 2020 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579014012;
        bh=wZAeBG/QB99EvNMIIrwR0lWvc+fiDBkZfsPGpQyHF5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMtGFNqDJxjiAsazUJ8a0Ba0zD9RbYKtgaP5FZhL+m1/Pwt9hzt5MNMKQFpoeeS0b
         3JWfksLlhGCXv3C6nBktxYL3vGn975soiPly1/PNzFMAOcZCrtGwWndJIMmg89TerG
         sFquLid46urgIHu82P0msmWhLwqQdjH+8DwUPGn4=
Date:   Tue, 14 Jan 2020 16:00:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     andre.pascoal.bento@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 101/101] Accessibility: braille: braille_console: fixed
 three missing black lines coding style
Message-ID: <20200114150009.GA1964134@kroah.com>
References: <20200109020125.16019-1-andre.pascoal.bento@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109020125.16019-1-andre.pascoal.bento@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:01:25AM +0000, andre.pascoal.bento@gmail.com wrote:
> From: andrepbento <andre.pascoal.bento@gmail.com>
> 
> Fixed three missing blank lines after declaration.
> 
> Signed-off-by: andrepbento <andre.pascoal.bento@gmail.com>

I need a "real" name here, something you would use for documents.

Please fix up and resend.

thanks,

greg k-h
