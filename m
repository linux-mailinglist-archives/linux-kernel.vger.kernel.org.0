Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665FA13EE93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395079AbgAPSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:09:36 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43895 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbgAPSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:09:33 -0500
Received: by mail-ot1-f51.google.com with SMTP id p8so20186373oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQb8Uq0IKx193QyLS3C+yGAjzOMy3a3CukknBRN2elo=;
        b=Z9dKYGG/It3ZDq626KVAn3UYMJ8w5rR7FNp1xgY+lJV2JdQ8DWHIetf1F8KloLda3X
         39gAmzG6xzkqr5D4Ak+0h08VxlZHpS0TnHAHHZwNZrxSD9H0o70ll3pjpzqbXTbh1DKL
         DNBT464rgyw5mNlpF54auwQ7W0YShGDSgsOZLiQe9UuUK/EI3rXInwadnnG1lGK7QCU1
         3w5gr6gsDviIi8iAJ4m/+JCGUJ3agwdBGY3e7V1tUCcAsasgKFwzh4MHrwHdLzXIgLAk
         x0PHbDzD2veOuVMZQjGO+cEu0iHunQLVEGPuaT782qMLmcgX5LnyP/rsd3PiYSGCcLoS
         c59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQb8Uq0IKx193QyLS3C+yGAjzOMy3a3CukknBRN2elo=;
        b=IOspGWkjNIKUHEA/4KRB9OHuwmPoB7r5E0OVHTIV68hjypA6VXJ8GO9LibjyHOEIex
         /XruPGrLPJChq7aBMIAYDz9Gonb5/ejO06u9BiYxYFs07FWj9VsDJnUtko9XutkCh2W8
         LlrXfAfCkd2BtPauosg5kUZDoGLJIYZ/I3DPuR8fTD3QmUDAgswQFAmI9kyvIo20HcxP
         rZZIgYP7HW/ECt/MOlGttLsgGQKXka3AuhHXeWDNMxp+HgTsnmaOIG5MZmky7kuy5Swf
         oUMz0/dQiKPxthNceCcr0NtBMC61TmqL8+DZIqUFkFMxREe9SjCFalqX8hgvWePpE/TE
         Ss5g==
X-Gm-Message-State: APjAAAVpZD7pLwSvy0Z+/GPI32uPtfvxrG3WMxit+mHkStbfQqjBbWT6
        eUwnWRyYJJ4q+Jt9bxUGnayW36ovMIV4O8lpEYCYNY0Q
X-Google-Smtp-Source: APXvYqyXr3lS+JZj9aYaGZcaZ677aNc3G5lICFsM5cpGfCF42dv3olbejurJoFC1AmwOnpAVRiOEEAY2CuZWxYa6P3Q=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr3079638otq.126.1579198173237;
 Thu, 16 Jan 2020 10:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20200106181117.GA16248@redhat.com> <20200116145403.GB25291@redhat.com>
In-Reply-To: <20200116145403.GB25291@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Jan 2020 10:09:22 -0800
Message-ID: <CAPcyv4hNQ3qtF1CA5Bb3NkSyUbw+_3CCY2e97EMXS4jfHTF7ag@mail.gmail.com>
Subject: Re: dax: Get rid of fs_dax_get_by_host() helper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 6:54 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Jan 06, 2020 at 01:11:17PM -0500, Vivek Goyal wrote:
> > Looks like nobody is using fs_dax_get_by_host() except fs_dax_get_by_bdev()
> > and it can easily use dax_get_by_host() instead.
> >
> > IIUC, fs_dax_get_by_host() was only introduced so that one could compile
> > with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
> > the same purpose and hence it looks like fs_dax_get_by_host() is not
> > needed anymore.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>
> Hi Dan,
>
> Ping for this patch. How does it look to you. If you don't have concerns,
> can you please take it in your tree.

Yes, looks good and applied.
