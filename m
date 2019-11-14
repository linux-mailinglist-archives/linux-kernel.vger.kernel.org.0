Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D08FBB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 22:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 16:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfKMVqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:46:18 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB17E206EE;
        Wed, 13 Nov 2019 21:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573681579;
        bh=p4LgxRcorK8+4QMe8TlUeaPStbYugBI0jHUkJ6GB4kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3UhhFd4o12VTQHIBpl9OmhmeJSf0Su/Cr0qVon3yFolAxv/lO9dZjNudf7pbLp9b
         G/Lu20g3Z4xJeW/pTRU01tjUvV2Ze04uDT5Y48BI7fvOzk43gS/xnAQ13j7E7EmiMp
         +lFOhR6RVxiur283V7kRZ7Z93R+oLUYgJEZ0KoOc=
Date:   Thu, 14 Nov 2019 05:45:57 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Javier F. Arias" <jarias.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] staging: rtl8723bs: Add necessary braces
Message-ID: <20191113214557.GA3926041@kroah.com>
References: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:52:39AM -0500, Javier F. Arias wrote:
> This patchset adds braces when they should be used on all arms of
> the statement.
> Issue found by Checkpatch.
> 
> Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
> ---
> Changes in V3:
> 	- No changes.

You forgot to properly cc: the correct mailing list and developers as
asked previously.

Do so and resend this series please.

thanks,

greg k-h
