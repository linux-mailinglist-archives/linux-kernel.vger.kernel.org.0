Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC27A13AD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgANPKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgANPKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:10:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307D12467D;
        Tue, 14 Jan 2020 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579014599;
        bh=5A8s18n5TTB7Q56nykLnKXFsEQVAbBeijgOYO3qJcVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ld+2kef90NSp9PSe7NiX8A+1kvEnV8dxIAOiJBsIT1rR1vkx4NhqKDJ9vLXoCJXxZ
         Rw0kF1Q6YvBoDoGw2rPTJ3s6HJDrFuYtTiLxfkmpbuUqesjksgZRY1zkwOy7UFgKsm
         x9kTU4rZcfGBHsO02DqnUd/hMdHsOwMOiN4DlAmc=
Date:   Tue, 14 Jan 2020 16:09:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] component: fix debugfs.
Message-ID: <20200114150956.GA1977145@kroah.com>
References: <20191218141207.23156-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218141207.23156-1-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:12:07PM +0100, Arnaud Pouliquen wrote:
> In component_devices_show function, the data field
> of the component_match_array structure can not match with the
> device structure type. As mentioned in component_match_add_release
> description, data field type is undefined. This can result to an
> unexpected print or can generate an overflow.
> Seems no generic way to get the component name, so this patch
> prints the component device name only if registered.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Good catch, someone else fixed this right before you did, so I'll queue
up that patch, thanks.

greg k-h
