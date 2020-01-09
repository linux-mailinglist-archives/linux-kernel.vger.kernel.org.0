Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2461354D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 09:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgAIIx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 03:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgAIIx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:53:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB0120678;
        Thu,  9 Jan 2020 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578560036;
        bh=333Hbnxqz+XVDFKQ9d5R16QWhZEe2F6MfWwtMRCWkys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QinQ/Hc7JoG5hQA6146IOd5vipiURpdR/wh393+Lv8PycCy/pivgl+B5PX+a3XYMp
         EVHERjL4tcKTtc7Dxg34GKOebYpMbj4i5oWCi29wVEoGF+DHMh2fMzU6rUsovnbpPV
         owUeemU82DVLxdhgcW1ZX0o+GreTHNbVuIT4NWUk=
Date:   Thu, 9 Jan 2020 09:53:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: bus: use simple sprintf for sysfs
Message-ID: <20200109085354.GA2583500@kroah.com>
References: <20191126123002.4835-1-tomas.winkler@intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DD64927@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DD64927@hasmsx108.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:28:56AM +0000, Winkler, Tomas wrote:
> > 
> > Replace scnprintf with simple sprintf for sysfs files.
> > it is implicitly known that the buffer is big enough for the variables to fit in.
> > 
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Hi Greg, hope you have great holiday,  has anything changed in the misc-char dev process,
> no patches were staged including this one?

$ mdfrm -c ~/mail/todo
1430 messages in /home/gregkh/mail/todo

I am way behind due to the holidays, please give me a chance to catch
up, especially for trivial stuff like this :)

thanks,

greg k-h
