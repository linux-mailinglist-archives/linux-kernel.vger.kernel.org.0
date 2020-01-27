Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B933D14AA24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 20:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0TAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 14:00:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39659 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0TAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:00:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id 4so5605781pgd.6;
        Mon, 27 Jan 2020 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6sl1WyHJ4Ip52KUSKf7apZBysjt7eqvb1zHoaMOHOw=;
        b=Qz1gUD7mJddt+heAmFgSTshMOyPBuO0vbPZguVq1Xld4KOl4Ze16AAaGB6g+jvt2ph
         sl80BH6J6Iw8cg6orTLYgnxu8EaZvdkGTuH6Z7TuQytJD5xLxie8YNC6g3sQchhuanbc
         ahiKGgIT/h1Nxuq/UCjZvz4DJHgqj8mnVvuyRtuZBEI/I0JbPV0kYKhdGaQHloWX5Iu0
         nCEmzE7HC8olP1mW0qJiM0ZonKZlKDa4bg52ncLT7tyR6+o87s2h2FCZ36yCgjXjL4J7
         o5iN1l89tjx3zpN04G6+LZ7htHXtVtU+LhwEJFF5S1fd0k02PJZsjR+7eqyEohQuG5mr
         G9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6sl1WyHJ4Ip52KUSKf7apZBysjt7eqvb1zHoaMOHOw=;
        b=FY/Ab97Gm9nilb7j8XefSeyPhJMBJ6UmBGwQ9FcsSg6AYjk0OE+2PqLq9v/DgQ3KrE
         t2L20wlcx1eXs0PSAQFryFzw4opI7VlHn89FJMFXeg5eTgBQMdG0/lB9ntuMyTSL++bX
         5mI3s34fRJ/uJ/7+huJGaI9wFzV5Yq6vhmv30y92tNEine8gxPTLakstsR7fs/3ifOOL
         ZZSX5bCvugIfh64OikPx3CZn+VwpLIueZ4Z38ujo5+ZaOzowT9yWOhuyqe9IlXiEHp+h
         lrx5n7/zEjNa2fi+BIkoMheK1/UwC+f86G32tc7hjiofXP2Z16g9nNnmGfBilBw9wMzc
         ZLNw==
X-Gm-Message-State: APjAAAUpIE77gxKbJidqVt9CT4lplf+rx0Vqx8QSrBr9Ehc09ZxfYBle
        j3S6sQ2iW/YCOMNSCX1FGsFi4DyXw5Hp5ixF2R0=
X-Google-Smtp-Source: APXvYqxbKhlEoUxLh6NaLra5dXJLQg0YH2Fwt1lIbowYePNbzGr63mPVZjVOJDC5Kp3xnXQ+n5vA/87S+9x9Sa9/dlM=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr77330pfa.64.1580151604306;
 Mon, 27 Jan 2020 11:00:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579890793.git.gayatri.kammela@intel.com>
 <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com> <BL0PR11MB31071AD85775C09B8EC26608F20B0@BL0PR11MB3107.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB31071AD85775C09B8EC26608F20B0@BL0PR11MB3107.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jan 2020 20:59:48 +0200
Message-ID: <CAHp75VeRAWsqxfjOxw97SBPRLvcyF=SGrN84hT=UUNC6yQ6-_A@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Box, David E" <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 8:03 PM Kammela, Gayatri
<gayatri.kammela@intel.com> wrote:

> > It doesn't apply to our for-next branch.
> Sorry to hear that. I've rebased the series on mainline 5.5-rc7. Should I rebase it on for-next branch?

You should always base your branch on the for-next (whatever it's
being called) of the subsystem your series against of.

-- 
With Best Regards,
Andy Shevchenko
