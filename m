Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5778418B121
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 11:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgCSKU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 06:20:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37300 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgCSKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:20:58 -0400
Received: by mail-io1-f65.google.com with SMTP id q9so1662857iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uJMFn0u6UxefMNCwOE+EpY1xkVMEUZdfQJs905Mo2E=;
        b=Tlo9ynl0/5JrUqt87TGFCCZ9Vf+ZY7VhurKDOOeDokSrKWXo+/6u5JNa2yUMyt8Sia
         io4XQ4NG9D33UhB3vjwQTLRHm2Ah7RPluXewGImqqQkybMb8AWDtp/5wmG/ZVQFcoMTq
         PnyKz6Odg2m53v/aAeWggFliHykA8ks7QBe1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uJMFn0u6UxefMNCwOE+EpY1xkVMEUZdfQJs905Mo2E=;
        b=KmiYs/8trlQKQJi01NgHjq6fnhd7IDLWqlJVbW9AAuQPs1THb7aD2wHqNQmmCD+6JQ
         2XB1rewsWea8+slOYNwCphkn8bb0IGByQh4wjKajHGvcexNnyiwZaq6uOq9q6zhLXiu4
         u9jgIS9qvtCTy4v46E9LaioqkyPVGedgGF0IUkh40vodhzN4kT+WffAqB85N+uLL+vae
         26biKstUjtPx77JFuvEJJ1PNBciINOTVjEeMycm8pN3PCr5fOp7XxMhO0WqmKRZEidS6
         GxpzlqFuPjmO/vBWGKEU9LQJn/bcooXMXlYEwq0PObGCbdDD3jxXYw7mLh1ppdKrO0FZ
         Of8A==
X-Gm-Message-State: ANhLgQ1O69Qsg9zpQE2V+d6hao5iYL9sbgs3M5XoF+7JUytOxwa9Tn/k
        L2qQOA0xNEE/anZiaY2lZL044JdZLO5DbHwAM/ycMg==
X-Google-Smtp-Source: ADFU+vtK3d/gDrUHwaxaJnUYjeJVHLK/PG6GuACnlbXxXQUQIi/qPHvAaGxP4FQ5mOe7IXI4kbNLAEMtUXVPu4O/o3c=
X-Received: by 2002:a02:241:: with SMTP id 62mr2290953jau.103.1584613255796;
 Thu, 19 Mar 2020 03:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200318171003.5179-1-jagan@amarulasolutions.com>
 <20200318171003.5179-3-jagan@amarulasolutions.com> <20200318185814.GB28092@ravnborg.org>
In-Reply-To: <20200318185814.GB28092@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 19 Mar 2020 15:50:44 +0530
Message-ID: <CAMty3ZDhVfvYXV7OO+NT+d_2YHbsJXebzjdtYkqtdD+X=Ch0yQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Update feiyang, st7701 panel bindings
 converted as YAML
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:28 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Mar 18, 2020 at 10:40:03PM +0530, Jagan Teki wrote:
> > The feiyang,fy07024di26a30d.txt and sitronix,st7701.txt has been
> > converted to YAML schemas, update MAINTAINERS to match them again.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> The patch is fine.
> I just dislike we repeat the maintainer info in two places..

Since these are two different panels. and entry similar like other
panels.do you look for single entry for both the panels?

Jagan.
