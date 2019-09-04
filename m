Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5790BA81DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 14:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfIDMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 08:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDMHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:07:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C539822CF5;
        Wed,  4 Sep 2019 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567598855;
        bh=W8204uRk38GPqCiR1KdVEb1ORO35v8ANNp4XVX3RkaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIy+MIJXphpu2Xj2+jrhMIr3nLXnch3D38RnAqupW2JRTMz0Ni0MJ74Ba/DpyBUWb
         LNjlLqtck1HnMy9jazFnNh1SGRQ6H8knTMuJ9Lzrvs4tcKY3ZYHkhQCSZXKEQF9Ypn
         naTZJxI75zGkEYFZ1gObdKOd+IQ6ORiXUZp4zprA=
Date:   Wed, 4 Sep 2019 14:07:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 2/2] software node: Initialize the return value in
 software_node_find_by_name()
Message-ID: <20190904120732.GB15829@kroah.com>
References: <20190830075156.76873-1-heikki.krogerus@linux.intel.com>
 <20190830075156.76873-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830075156.76873-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:51:56AM +0300, Heikki Krogerus wrote:
> The software node is searched from a list that may be empty
> when the function is called. This makes sure that the
> function returns NULL if the list is empty.
> 
> Fixes: 1666faedb567 ("software node: Add software_node_get_reference_args()")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
