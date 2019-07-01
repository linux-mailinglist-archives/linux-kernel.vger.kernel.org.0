Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E410598
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 08:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfEAGpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 02:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfEAGpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:45:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD6920651;
        Wed,  1 May 2019 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556693104;
        bh=zSQyJXYEzJbwz+ZrGQYkRZ+BmF0JOB9TUf4M8D0kTPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R78rUUaILBs4zPfIzHECy3LSHnmS8twK2vndMD6FgCnljFexsHGWNcM5HQforE769
         aoitIA8d6kWE11+5/Se19N9SpRiWEHn5hSFxXq93ohaCsnZ+OuGZpUc0ItXxXeWasJ
         +S0L1s/uBoC62Jq7g7b18xRDAc8ke8QCYqCElF1s=
Date:   Wed, 1 May 2019 08:45:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Vijay Khemka <vijaykhemka@fb.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
Message-ID: <20190501064501.GA20816@kroah.com>
References: <20190116220154.1026171-1-vijaykhemka@fb.com>
 <1547787502.2061444.1637712576.1F1E21B4@webmail.messagingengine.com>
 <DCD8D2E5-DB18-427C-AA8F-18289E9AB0AB@fb.com>
 <CACPK8Xdgv1YVgeykf0grSpR3LXTGa45hoBwZVq+zWgR0anhmTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xdgv1YVgeykf0grSpR3LXTGa45hoBwZVq+zWgR0anhmTg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 05:55:07AM +0000, Joel Stanley wrote:
> On Fri, 18 Jan 2019 at 20:12, Vijay Khemka <vijaykhemka@fb.com> wrote:
> >
> > Hi Andrew,
> > Thanks for this review, I will have a follow up patch for this return values.
> 
> Did you send a follow up patch to fix the return values?
> 
> Greg, is there any reason why you did not merge this one? 5.2 will
> have device trees that depend on this patch's behavior.

No idea, if it needs to be applied, please resend.

thanks,

greg k-h
