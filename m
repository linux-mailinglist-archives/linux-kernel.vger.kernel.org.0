Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99DAFAEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 11:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKMKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 05:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfKMKns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:43:48 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863CD21783;
        Wed, 13 Nov 2019 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573641828;
        bh=MvS0YJc2NcLZnl7ux2NooCbUzDBcliTDOr3GIDj014I=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Hee3uwVHhqmxTaDIYPqheVUNonJBm64OB4bjpcfMMXLYSu9sbVl1rLZEYLeJj2k/1
         dXT6dTIX7qmLdPfooohmMZHvkXo7HPRm5JCDt34s5EslGimSJgiQPFNdyea1+SbxVf
         R/AXqgDdIzQR1AvBI9mv5aUy5yZ5eMKIpmZ1emMY=
Date:   Wed, 13 Nov 2019 11:43:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH v2 2/4] staging: rtl8723bs: Fix
 unbalanced braces
Message-ID: <20191113104344.GA2068945@kroah.com>
References: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
 <ff5bb9f30fd27f68a9b8977094d56c844ba307df.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5bb9f30fd27f68a9b8977094d56c844ba307df.1573605920.git.jarias.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:36:12PM -0500, Javier F. Arias wrote:
> This patch fixes unbalanced braces around else statements. It also
> removes an empty else block.

No, it only did one thing here, not 2 :(

