Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65810926
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfEAOdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 10:33:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36726 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfEAOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:33:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id b18so5909225otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxQbVhRh1k7NQOtu+xKGQSEg3+pzRS1OuFWZAW1pByY=;
        b=vKWfwlKzj/4UtyLK1JEAkMBeVxTCfZXywq27mb6PRLzkLmcDH9AWbvSP9YJmU9EaSQ
         GdRW2UdHxitNBmv8MKnNmNBoRKn4Ky9UfZTIMpgAdBSUAd7w1162PR7Wy15ZSbuvtjAX
         typCmIwSevLAIZMzexMYBtDryKLDAairU+JyoJO8AXTgfwyOzGI/0Kq9xL9iAXUkTz+k
         MubquY9AFcY41bW33/OkcGnmW3YPb+n0ahMO0eYDhGFCy6TsCuYg6q0zCCYx0hHcR/FW
         YYNo134ynyV/O2DakpE0SwrTBy6/zt5oGB4R7SlNSPL8Qmji1QW7Kko/wCyKyC89ZT0H
         7J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxQbVhRh1k7NQOtu+xKGQSEg3+pzRS1OuFWZAW1pByY=;
        b=VPsNFXt+xQm+t3G0fT6BNegoHaCmDJGTssD4Cl00jbL1lqIcda3de8RPW6KGiC0zQ0
         Hz2SWU/jCNe618ZtkHlNkWnPxvDH05OY6gFcxS5fu13GnD20u5QtG8u2UbpkEo2adn2X
         b8SWsYEctRo+DZfT3HyuKrG7ONaXenEUFYumd5fe9WfaxTHXa69JncITq+hT0/OucSXG
         Se3RTEaKMjqG96u0RLl4cQuuEGdMszIWYqLA0pyf3YRQeSnTMOn8xSuRm6gGLwmiS3Sp
         DT/bKsQB7RRdM4mDRo1wNJBxMSSVKazZtUo8i+7RE9Q9y40pbga/f0jHqC2uyplw6NbC
         T0qA==
X-Gm-Message-State: APjAAAXZDus0Vt6lp9pQBe6VVifDQUtGdUzvW2nW9NLZFaa2BLNWmzWO
        wWX3BbKB71L8wG/LPQhp8BIPgkfTMG2In5My+J8=
X-Google-Smtp-Source: APXvYqzrLc32hqH3bP6DDkBs2SYair861UZyQuuPLsPUZCV9iLfcgxl8pXdS0Ox5bY1pFlaz7w9MwuRe1HMQJ2ri6iQ=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr14848905oti.18.1556721219148;
 Wed, 01 May 2019 07:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190501140624.6931-1-TheSven73@gmail.com> <20190501142332.GA13008@kroah.com>
In-Reply-To: <20190501142332.GA13008@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 1 May 2019 10:33:28 -0400
Message-ID: <CAGngYiXAz-10BtMs6K1mNwHgakK=U80hX4+Cf6tG8Vc3Ag=NOA@mail.gmail.com>
Subject: Re: [GIT PULL] staging/fieldbus-dev for 5.2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 10:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> I don't "trust" the gitlab infrastructure, sorry, and I don't think I
> have a valid gpg signature from you anywhere :(

What infrastructure do you trust? GitHub?
Just in case I need this in the future - I really don't want to start
a political thread :)
