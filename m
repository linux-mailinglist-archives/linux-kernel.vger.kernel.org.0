Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAB7D5576
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfJMJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 05:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfJMJXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 05:23:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D4920659;
        Sun, 13 Oct 2019 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570958582;
        bh=WbyZGAhucOOfrVVsBUwNKEpbTNgy62toVvp3TcErWoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HicUqv4NJPgLGZHWne8a7PKGoteNbg2vRjF2gAo3GRxVZEJ2eD7zWCNPhbllSdPME
         ULQ0+wwn/hDf/+bDKa9gXc1TTdpNvwsbR3Z7h+6Ky25z0LRg8RywThuk8ePcgGURFM
         d1i70qcEfGuuCM/imqSXsKfE5knOEc7mnFIK9y2w=
Date:   Sun, 13 Oct 2019 11:22:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        kurahul@cadence.com, Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH v2] usb: cdns3: Fix dequeue implementation.
Message-ID: <20191013092259.GA2412199@kroah.com>
References: <e611a60b-08e1-4077-8789-976c19e1ac93@maileu3.global.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e611a60b-08e1-4077-8789-976c19e1ac93@maileu3.global.cadence.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 10:09:20AM +0100,  wrote:
> From: Pawel Laszczak <pawell@cadence.com>

<snip>

Please look at your email client, your email had a _very_ odd "From:"
line.  Please fix that up.

thanks,

greg k-h
