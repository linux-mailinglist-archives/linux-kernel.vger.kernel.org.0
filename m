Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC61C9A50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfJCI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 04:59:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:40937 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbfJCI7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:59:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 01:59:31 -0700
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="195154654"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 01:59:26 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mat King <mathewk@google.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rafael@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
In-Reply-To: <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com> <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan> <8736gbbf2b.fsf@intel.com> <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
Date:   Thu, 03 Oct 2019 11:59:24 +0300
Message-ID: <87h84q9pcj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019, Mat King <mathewk@google.com> wrote:
> On Wed, Oct 2, 2019 at 4:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>
>> On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>> > On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
>> >> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
>> >> > Resending in plain text mode
>> >> >
>> >> > I have been looking into adding Linux support for electronic privacy
>> >> > screens which is a feature on some new laptops which is built into the
>> >> > display and allows users to turn it on instead of needing to use a
>> >> > physical privacy filter. In discussions with my colleagues the idea of
>> >> > using either /sys/class/backlight or /sys/class/leds but this new
>> >> > feature does not seem to quite fit into either of those classes.
>> >> >
>> >> > I am proposing adding a class called "privacy_screen" to interface
>> >> > with these devices. The initial API would be simple just a single
>> >> > property called "privacy_state" which when set to 1 would mean that
>> >> > privacy is enabled and 0 when privacy is disabled.
>> >> >
>> >> > Current known use cases will use ACPI _DSM in order to interface with
>> >> > the privacy screens, but this class would allow device driver authors
>> >> > to use other interfaces as well.
>> >> >
>> >> > Example:
>> >> >
>> >> > # get privacy screen state
>> >> > cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
>> >> > enabled 0: privacy disabled
>> >> >
>> >> > # set privacy enabled
>> >> > echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state
>> >> >
>> >> >  Does this approach seem to be reasonable?
>> >>
>> >> What part of the userspace would be managing the privacy screen? Should
>> >> there be a connection between the display and the privacy screen that
>> >> covers the display? How would the userspace make that connection if it's
>> >> a sysfs interface?
>> >>
>> >> I don't know how the privacy screen operates, but if it draws any power,
>> >> you'll want to disable it when you switch off the display it covers.
>> >>
>> >> If the privacy screen control was part of the graphics subsystem (say, a
>> >> DRM connector property, which feels somewhat natural), I think it would
>> >> make it easier for userspace to have policies such as enabling the
>> >> privacy screen automatically depending on the content you're viewing,
>> >> but only if the content is on the display that has a privacy screen.
>> >
>> > Connectors versus sysfs came up on a backlight thread recently.
>> >
>> > Daniel Vetter wrote an excellent summary on why it has been (and still
>> > is) difficult to migrate backlight controls towards the DRM connector
>> > interface:
>> > https://lkml.org/lkml/2019/8/20/752
>> >
>> > Many of the backlight legacy problems do not apply to privacy screens
>> > but I do suggest reading this post and some of the neighbouring parts
>> > of the thread. In particular the ACPI driver versus real driver issues
>> > Daniel mentioned could occur again. Hopefully not though, I mean how
>> > wrong can a 1-bit control go? (actually no... don't answer that).
>> >
>> > It would definitely be a shame to build up an unnecessary sysfs legacy
>> > for privacy screens so definitely worth seeing if this can use DRM
>> > connector properties.
>>
>> Indeed. I'm painfully aware of the issues Daniel describes, and that's
>> part of the motivation for writing this.
>>
>> Obviously the problem with associating the privacy screen with the DRM
>> connector is that then the kernel has to make the connection, somehow,
>> instead of just making it a userspace problem.
>>
>> BR,
>> Jani.
>>
>> --
>> Jani Nikula, Intel Open Source Graphics Center
>
> I am not familiar with the DRM connector interface and I don't quite
> understand how it would work in this case. How would the connector
> provide control to userspace? Is there documentation or example code
> somewhere that you could point me to?

Here are some links, from the general to more specific. Don't get
overwhelmed. ;)

https://www.kernel.org/doc/html/latest/gpu/index.html
https://www.kernel.org/doc/html/latest/gpu/drm-kms.html
https://www.kernel.org/doc/html/latest/gpu/drm-kms.html#kms-properties

The kms userspace tests have some example code. Likely pretty far from
what a nice userspace would actually look like, but you get the idea.

https://gitlab.freedesktop.org/drm/igt-gpu-tools/blob/master/tests/kms_properties.c

Finally, the larger point all along in exposing this via connector
properties is that this could be integrated to some graphics userspace
for a nice user experience, instead of scattering a bunch of userspace
APIs for the same feature across the kernel, and then desperately trying
to gather them to a coherent experience in userspace.

In fact, to that end we have rather more strict requirements for
userspace APIs in drm than perhaps the rest of the kernel:

https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-userspace-requirements

Just shoving this into sysfs or procfs to get the kernel part done is
technical debt that ultimately has to be paid by userspace. The
backlight sysfs interface is ancient, and we didn't know better. We
don't have that excuse anymore.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
