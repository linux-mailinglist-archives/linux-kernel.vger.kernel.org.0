Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90DDCAFA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfJCT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 15:57:30 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43112 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfJCT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:57:30 -0400
Received: by mail-yw1-f67.google.com with SMTP id q7so1476899ywe.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwGFguokm+nRz8TH1dg7GrPgOPpgQoQW2OgkbVebOrc=;
        b=Rcqc1Of1ikFmgGO7L0NxG0jXlY+/dkwjYeqoRbGMlEJi3W77JS5JSygXMzKUzZ4B5w
         zatea+mqBxZT8QtEzG9fzkAm1sC1+Zdy/BaGRTM+/Pa+UsaIktraZmIK/mlgL7hvuYOj
         uH24oJltswaHsFBx7ivi6yFNOp5RHb0P7y82+d5hKfYexh43yeCG/3GqqFipEV6Z8FpU
         RQ388TueWjSK8xppgwLezeGKYyi4GKxPWOec3+PET6/Ow629BfvuUW/EcsF+xJ5nYJfu
         vZlFo0DDVGlVZMHvfoSKsnHA+UlyPcqWwcOADRiTS/aXcC88skqZVrI+AJh2JOpVyYKY
         ZZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwGFguokm+nRz8TH1dg7GrPgOPpgQoQW2OgkbVebOrc=;
        b=I6S0VfukTobSrj3euH+3/ZCH5w9CP/VmtC79EinYW+MWtiRh+cSJ3C68WgfaG4FLcf
         riBiUQistiuJeDqkZRIIs32nDjxB3AI4jKyGTgxUTHnUFglymb2fQu8aAlUTVoJKXeKF
         o/dNQr54X8IjVwzLIRccU7FpEcow9duesKpL1pVNs4sThTMpnnwA+7VWVvJKd9KneTwa
         pkIGWf+ziqOYF5IdZZdAQ1Tq7jxuFtXtfz6ji3f/uSvkmH20s6GPSBNLOjyVtG7idwst
         ZfVuaep+ysp62RJ51w39DbtT5K47h4672BEKtj6CQC/pLlce8Uja2ujsBETsrsdM17ze
         vk/w==
X-Gm-Message-State: APjAAAUE1BCXpwudz4ZNEzJlaC4Uysmd8VKZm3kv2u2niTq+bAxftWZm
        yzSLAxTRb0NtGHHnE8RymtpWMJv73mfJAcwuonvf9Wpa+bfojVPw
X-Google-Smtp-Source: APXvYqzt/1vtRTXMO6CPc3gOjRA99QLIdenJ/6D01AtvYfi2OuOg7CGF/byoH7HBRckOfZ8XOoJ90XvGTfY1GK7JG4I=
X-Received: by 2002:a81:9952:: with SMTP id q79mr7661335ywg.98.1570132647764;
 Thu, 03 Oct 2019 12:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan>
 <8736gbbf2b.fsf@intel.com> <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
 <87h84q9pcj.fsf@intel.com>
In-Reply-To: <87h84q9pcj.fsf@intel.com>
From:   Mat King <mathewk@google.com>
Date:   Thu, 3 Oct 2019 13:57:16 -0600
Message-ID: <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rafael@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:59 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Wed, 02 Oct 2019, Mat King <mathewk@google.com> wrote:
> > On Wed, Oct 2, 2019 at 4:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >>
> >> On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> >> > On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
> >> >> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
> >> >> > Resending in plain text mode
> >> >> >
> >> >> > I have been looking into adding Linux support for electronic privacy
> >> >> > screens which is a feature on some new laptops which is built into the
> >> >> > display and allows users to turn it on instead of needing to use a
> >> >> > physical privacy filter. In discussions with my colleagues the idea of
> >> >> > using either /sys/class/backlight or /sys/class/leds but this new
> >> >> > feature does not seem to quite fit into either of those classes.
> >> >> >
> >> >> > I am proposing adding a class called "privacy_screen" to interface
> >> >> > with these devices. The initial API would be simple just a single
> >> >> > property called "privacy_state" which when set to 1 would mean that
> >> >> > privacy is enabled and 0 when privacy is disabled.
> >> >> >
> >> >> > Current known use cases will use ACPI _DSM in order to interface with
> >> >> > the privacy screens, but this class would allow device driver authors
> >> >> > to use other interfaces as well.
> >> >> >
> >> >> > Example:
> >> >> >
> >> >> > # get privacy screen state
> >> >> > cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
> >> >> > enabled 0: privacy disabled
> >> >> >
> >> >> > # set privacy enabled
> >> >> > echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state
> >> >> >
> >> >> >  Does this approach seem to be reasonable?
> >> >>
> >> >> What part of the userspace would be managing the privacy screen? Should
> >> >> there be a connection between the display and the privacy screen that
> >> >> covers the display? How would the userspace make that connection if it's
> >> >> a sysfs interface?
> >> >>
> >> >> I don't know how the privacy screen operates, but if it draws any power,
> >> >> you'll want to disable it when you switch off the display it covers.
> >> >>
> >> >> If the privacy screen control was part of the graphics subsystem (say, a
> >> >> DRM connector property, which feels somewhat natural), I think it would
> >> >> make it easier for userspace to have policies such as enabling the
> >> >> privacy screen automatically depending on the content you're viewing,
> >> >> but only if the content is on the display that has a privacy screen.
> >> >
> >> > Connectors versus sysfs came up on a backlight thread recently.
> >> >
> >> > Daniel Vetter wrote an excellent summary on why it has been (and still
> >> > is) difficult to migrate backlight controls towards the DRM connector
> >> > interface:
> >> > https://lkml.org/lkml/2019/8/20/752
> >> >
> >> > Many of the backlight legacy problems do not apply to privacy screens
> >> > but I do suggest reading this post and some of the neighbouring parts
> >> > of the thread. In particular the ACPI driver versus real driver issues
> >> > Daniel mentioned could occur again. Hopefully not though, I mean how
> >> > wrong can a 1-bit control go? (actually no... don't answer that).
> >> >
> >> > It would definitely be a shame to build up an unnecessary sysfs legacy
> >> > for privacy screens so definitely worth seeing if this can use DRM
> >> > connector properties.
> >>
> >> Indeed. I'm painfully aware of the issues Daniel describes, and that's
> >> part of the motivation for writing this.
> >>
> >> Obviously the problem with associating the privacy screen with the DRM
> >> connector is that then the kernel has to make the connection, somehow,
> >> instead of just making it a userspace problem.
> >>
> >> BR,
> >> Jani.
> >>
> >> --
> >> Jani Nikula, Intel Open Source Graphics Center
> >
> > I am not familiar with the DRM connector interface and I don't quite
> > understand how it would work in this case. How would the connector
> > provide control to userspace? Is there documentation or example code
> > somewhere that you could point me to?
>
> Here are some links, from the general to more specific. Don't get
> overwhelmed. ;)
>
> https://www.kernel.org/doc/html/latest/gpu/index.html
> https://www.kernel.org/doc/html/latest/gpu/drm-kms.html
> https://www.kernel.org/doc/html/latest/gpu/drm-kms.html#kms-properties
>
> The kms userspace tests have some example code. Likely pretty far from
> what a nice userspace would actually look like, but you get the idea.
>
> https://gitlab.freedesktop.org/drm/igt-gpu-tools/blob/master/tests/kms_properties.c
>
> Finally, the larger point all along in exposing this via connector
> properties is that this could be integrated to some graphics userspace
> for a nice user experience, instead of scattering a bunch of userspace
> APIs for the same feature across the kernel, and then desperately trying
> to gather them to a coherent experience in userspace.
>
> In fact, to that end we have rather more strict requirements for
> userspace APIs in drm than perhaps the rest of the kernel:
>
> https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-userspace-requirements
>
> Just shoving this into sysfs or procfs to get the kernel part done is
> technical debt that ultimately has to be paid by userspace. The
> backlight sysfs interface is ancient, and we didn't know better. We
> don't have that excuse anymore.
>
>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel Open Source Graphics Center

Thanks Jani, the DRM connector picture is much more clear now after
reading through those.

So my proposal would now be to add a new standard property to
drm_connector called "privacy_screen" this property would be an enum
which can take one of three values.

PRIVACY_UNSUPPORTED - Privacy is not available for this connector
PRIVACY_DISABLED - Privacy is available but turned off
PRIVACY_ENABLED - Privacy is available and turned on

When the connector is initized the privacy screen property is set to
PRIVACY_UNSUPPORTED and cannot be changed unless a drm_privacy_screen
is registered to the connector. drm_privacy_screen will look something
like

struct drm_privacy_screen_ops {
    int (*get_privacy_state)(struct drm_privacy_screen *);
    int (*set_privacy_state)(struct drm_privacy_screen *, int);
}

struct drm_privacy_screen {
    /* The privacy screen device */
    struct device *dev;

    /* The connector that the privacy screen is attached */
    struct drm_connector *connector;

    /* Ops to get and set the privacy screen state */
    struct drm_privacy_screen_ops *ops;

    /* The current state of the privacy screen */
    int state;
}

Privacy screen device drivers will call a function to register the
privacy screen with the connector.

int drm_privacy_screen_register(struct drm_privacy_screen_ops *ops,
struct device *dev, struct drm_connector *);

Calling this will set a new field on the connector "struct
drm_privacy_screen *privacy_screen" and change the value of the
property to ops->get_privacy_state(). When
drm_mode_connector_set_obj_prop() is called with the
privacy_screen_proptery if a privacy_screen is registered to the
connector the ops->set_privacy_state() will be called with the new
value.

Setting of this property (and all drm properties) is done in user
space using ioctrl.

Registering the privacy screen with a connector may be tricky because
the driver for the privacy screen will need to be able to identify
which connector it belongs to and we will have to deal with connectors
being added both before and after the privacy screen device is added
by it's driver.

How does that sound? I will work on a patch if that all sounds about right.

One question I still have is there a way to not accept a value that is
passed to drm_mode_connector_set_obj_prop()? In this case if a privacy
screen is not registered the property must stay PRIVACY_UNSUPPORTED
and if a privacy screen is registered then PRIVACY_UNSUPPORTED must
never be set.
