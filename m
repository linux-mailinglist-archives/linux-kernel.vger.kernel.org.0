Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514B01764AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCBUJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 15:09:13 -0500
Received: from ms.lwn.net ([45.79.88.28]:58496 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBUJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:09:13 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8EBB52E4;
        Mon,  2 Mar 2020 20:09:12 +0000 (UTC)
Date:   Mon, 2 Mar 2020 13:09:11 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     tbird20d@gmail.com
Cc:     mchehab@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tim.bird@sony.com
Subject: Re: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Message-ID: <20200302130911.05a7e465@lwn.net>
In-Reply-To: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 18:34:41 -0700
tbird20d@gmail.com wrote:

> With Ubuntu 16.04 (and presumably Debian distros of the same age),
> the instructions for setting up a python virtual environment should
> do so with the python 3 interpreter.  On these older distros, the
> default python (and virtualenv command) might be python2 based.
> 
> Some of the packages that sphinx relies on are now only available
> for python3.  If you don't specify the python3 interpreter for
> the virtualenv, you get errors when doing the pip installs for
> various packages
> 
> Fix this by adding '-p python3' to the virtualenv recommendation
> line.
> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>

I've applied this, even though it feels a bit fragile to me.  But Python
stuff can be a bit that way, sometimes, I guess.

Thanks,

jon
