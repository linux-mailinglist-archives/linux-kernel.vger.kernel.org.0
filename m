Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4DBEDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfIZI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 04:59:42 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:45449 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfIZI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:59:41 -0400
Received: by mail-vk1-f172.google.com with SMTP id u192so268515vkb.12;
        Thu, 26 Sep 2019 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McEd+9On6Ntx8uhur1Wb/vqGSrpb24pxGWS+he4c3dc=;
        b=PBXgeThnxaBmraGe6V0ZwMr8fTL5d8VmALJ0Y0a32M6SrQHkkb3eXPFSh35COWIMbd
         FVariCpAX7oDGFB0Z+Op9rNWXSsBhc0xn5hTuabGh+qysToiGXP29dmk93Pj0AT23cd+
         ZidnfBs+uhTridtSGVP6zzS6eXL0tN71sCEPf7GiRnr8mJqHPohR0umLeCJ8KDzipbIz
         8h/U/RXgumD91lULVFAT1IvH+zZvNDBydu5K3oc6VAfDRT7dvUuS2eFZr/AO0bMDKcOO
         PzvZ+gOoEx0rILjKAC7KnPtikmaKfdtsvGtI6rkBGSYiDbZKq0nWKzY1IA8bqFTQqdW2
         uq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McEd+9On6Ntx8uhur1Wb/vqGSrpb24pxGWS+he4c3dc=;
        b=Y3G6mQuQLFKlGIg3V/PxFTj6k0PN6gb4A22o0dNEWHM4XwosCcpUxoKBQdrLRxdbSH
         NB6gyx2KZMDtqCNKux2iMPkMdFwYBi5wXs84lNrAyAHO3orxISc17tHja6TXTl8DQAXz
         riToh6FMRdhJBIci8r/OC86MudWpw/zzx5sxWUqbDelN1srdfJtkHeuAU/vI3gOEOiT4
         CNvnHmoEA7xaK73qg59zdyNDnrS+PDnegseivgM+rks8AhpOF9Ax1y+NLpHYJ/6QY9k1
         nNYPNI+L9BmJNx4QLBzzbBpn+LT+oW6BvbHdpD1suGxDNdZbpTGdafLXIQVkYnQbWOQG
         7Tvw==
X-Gm-Message-State: APjAAAWboYQaxOBuo6+2sgave+oi6zc5xah4nl1ES32Vv2l+QUh1aitx
        7EleB16rtLfNVnJBgCZbUbhV1PNSoXYQMSBfew==
X-Google-Smtp-Source: APXvYqwK5OosKBQKb50Qxpn3riVd+PUNGSJtSyR6hJPTzTSDWVl84TiaMN7gzS7u6vdCaw+QFN4BzNaYBBOvUfoKa6k=
X-Received: by 2002:a1f:dc41:: with SMTP id t62mr1079220vkg.5.1569488380538;
 Thu, 26 Sep 2019 01:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190909184446.9049-1-rsalvaterra@gmail.com> <C9B9ED17-F82B-4F25-996E-C1880AC49E1B@holtmann.org>
In-Reply-To: <C9B9ED17-F82B-4F25-996E-C1880AC49E1B@holtmann.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 26 Sep 2019 09:59:29 +0100
Message-ID: <CALjTZvZPDTdKGQExSwo9QL3KL9+t99NLdDnZjEOrnWMUBEpwSg@mail.gmail.com>
Subject: Re: [PATCHv2] Bluetooth: trivial: tidy up printk message output from btrtl.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcel,

On Thu, 26 Sep 2019 at 07:34, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Rui,

[patch snipped]

> I have some similar patch in my tree. Can you check what is still missing and send a new version. Thanks.

Yeah, from a cursory look at your tree, it seems about the same as
mine. I'll take a deeper look later on (can't access the laptops to
test, ATM) and send a patch with any missing stuff, if needed.

Thanks,
Rui
