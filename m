Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64301FAEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 11:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfKMKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 05:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfKMKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:45:19 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51C4222D0;
        Wed, 13 Nov 2019 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573641917;
        bh=omdYK6XtMhbv1v/RiOXnCMGLXx1Yi9frz/as92P7Dsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT0SxUJqSCwc3KIYye9HuP2ReIeLdY1LEuKYuVRVzn2Ca/25yks9bwuTH/Y1Y5VPg
         JUV9DZpJsKlf5b5WYy1hRg3FCN/81xcEAgJrr3ydZukW8auJKzruoKPjGX9b2ffcdw
         ZwsdnAqYZqyhp198Fn48tpmgiMLRaib2GJ6oTWUQ=
Date:   Wed, 13 Nov 2019 11:45:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Javier F. Arias" <jarias.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging: rtl8723bs: Rename variable
Message-ID: <20191113104515.GC2068945@kroah.com>
References: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
 <1610b265f1c6ee0148002642836283fb3757a36f.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610b265f1c6ee0148002642836283fb3757a36f.1573605920.git.jarias.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:38:47PM -0500, Javier F. Arias wrote:
> This patch renames a variable name previously defined in uppercase.

That says what you did, but not _why_ you want to do it.

