Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1B37788
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfFFPNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 11:13:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58822 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbfFFPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:13:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 8B4DD260D74
Message-ID: <1cfc4bfab8d9d8a47e5dacaca88a7fe30ae83076.camel@collabora.com>
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, Enno Luebbers <enno.luebbers@intel.com>,
        Guido Kiener <guido@kiener-muenchen.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Corbet <corbet@lwn.net>, Wu Hao <hao.wu@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jilayne Lovejoy <opensource@jilayne.com>
Date:   Thu, 06 Jun 2019 12:12:50 -0300
In-Reply-To: <20190606145121.GA13048@kroah.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
         <20190604152019.16100-4-enric.balletbo@collabora.com>
         <20190604155228.GB9981@kroah.com>
         <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
         <20190604183527.GA20098@kroah.com>
         <CABXOdTfU9KaBDhQcwvBGWCmVfnd02_ZFmPGtJsCtGQ-iO9A3Qw@mail.gmail.com>
         <20190604185953.GA2061@kroah.com>
         <bda48bf80add26153e531912fbfca25071934c94.camel@collabora.com>
         <20190606145121.GA13048@kroah.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 16:51 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 06, 2019 at 11:01:17AM -0300, Ezequiel Garcia wrote:
> > On Tue, 2019-06-04 at 20:59 +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jun 04, 2019 at 11:39:21AM -0700, Guenter Roeck wrote:
> > > > On Tue, Jun 4, 2019 at 11:35 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Tue, Jun 04, 2019 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> > > > > > Hey Greg,
> > > > > > 
> > > > > > > > + dev_info(&pdev->dev, "Created misc device /dev/%s\n",
> > > > > > > > +          data->misc.name);
> > > > > > > 
> > > > > > > No need to be noisy, if all goes well, your code should be quiet.
> > > > > > > 
> > > > > > 
> > > > > > I sometimes wonder about this being noise or not, so I will slightly
> > > > > > hijack this thread for this discussion.
> > > > > > 
> > > > > > > From a kernel developer point-of-view, or even from a platform
> > > > > > developer or user with a debugging hat point-of-view, having
> > > > > > a "device created" or "device registered" message is often very useful.
> > > > > 
> > > > > For you, yes.  For someone with 30000 devices attached to their system,
> > > > > it is not, and causes booting to take longer than it should be.
> > > > > 
> > > > > > In fact, I wish people would do this more often, so I don't have to
> > > > > > deal with dynamic debug, or hack my way:
> > > > > > 
> > > > > > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > > > > > index 4589631798c9..473549b26bb2 100644
> > > > > > --- a/drivers/media/i2c/ov5647.c
> > > > > > +++ b/drivers/media/i2c/ov5647.c
> > > > > > @@ -603,7 +603,7 @@ static int ov5647_probe(struct i2c_client *client,
> > > > > >         if (ret < 0)
> > > > > >                 goto error;
> > > > > > 
> > > > > > -       dev_dbg(dev, "OmniVision OV5647 camera driver probed\n");
> > > > > > +       dev_info(dev, "OmniVision OV5647 camera driver probed\n");
> > > > > >         return 0;
> > > > > >  error:
> > > > > >         media_entity_cleanup(&sd->entity);
> > > > > > 
> > > > > > In some subsystems, it's even a behavior I'm more or less relying on:
> > > > > > 
> > > > > > $ git grep v4l2_info.*registered drivers/media/ | wc -l
> > > > > > 26
> > > > > > 
> > > > > > And on the downsides, I can't find much. It's just one little line,
> > > > > > that is not even noticed unless you have logging turned on.
> > > > > 
> > > > > Its better to be quiet, which is why the "default driver registration"
> > > > > macros do not have any printk messages in them.  When converting drivers
> > > > > over to it, we made the boot process much more sane, don't try to go and
> > > > > add messages for no good reason back in please.
> > > > > 
> > > > > dynamic debugging can be enabled on a module and line-by-line basis,
> > > > > even from the boot command line.  So if you need debugging, you can
> > > > > always ask someone to just reboot or unload/load the module and get the
> > > > > message that way.
> > > > > 
> > > > 
> > > > Can we by any chance make this an official policy ? I am kind of tired
> > > > having to argue about this over and over again.
> > > 
> > > Sure, but how does anyone make any "official policy" in the kernel?  :)
> > > 
> > > I could just go through and delete all "look ma, a new driver/device!"
> > > messages, but that might be annoying...
> > > 
> > 
> > Well, I really need to task.
> 
> ???
> 

Oops, typo: s/task/ask :-)

> > If it's not an official policy (and won't be anytime soon?),
> 
> The ":)" there was that we really have very few "official" policies,
> only things that we all strongly encourage to happen.  And get grumpy if
> we see them in code reviews.  Like I did here.
> 

Well, not everyone gets grumpy. As I pointed out, we use this "registered"
messages (messages or noise, seems this lie in the eye of the beholder),
consistently across entire subsystems.

> > then what's preventing Enric from pushing this print on this driver,
> > given he is the one maintaining the code?
> 
> Given that he wants people to review his code, why would you tell him to
> ignore what people are trying to tell him?
> 

I'm not suggesting to ignore anyone, rather to consider all voices
involved in each review comment.

> Again, don't be noisy, it's not hard, and is how things have been
> trending for many years now.
> 

Thanks,
Eze

