Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90C14CEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 17:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgA2Qu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 11:50:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42479 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgA2Qu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:50:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so43109pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 08:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnACTF0mg7+AZUrTeSaTlJDBtgVeUJkDSPQmQ/i+6ts=;
        b=s6ux0JBWLeR5W9OzYXqRzHK3paqGpf1pyCwTY01YQAPkWXUvUHWXMHSdICezVrOY0x
         zSs4kY2L9Fo07FoiCx8/FlvM0DP7pCAOsWDiNrOgxyxzhtuUl8fkRNXBvhRpn4VTvH6h
         Mxzsj8u+3G6AuRhZqhHVuO8z4uLudbrPb6FLii0MQJSkb/IXLtIYxz7IcB4GCpu0cGpI
         7xPNyXObhI8lgs5dJMuq+gm4sSVaiCtc9zYl/krKU6HT+asR7fj2P7RPzEPEHH+iyq8x
         QFWSTs8k1QaCy5opNgZUXAth5NitP3WiJLrbiQbBVfM120nGJtswBI9HKZxATubF9haA
         p0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnACTF0mg7+AZUrTeSaTlJDBtgVeUJkDSPQmQ/i+6ts=;
        b=hX9JEHf9YBVsERymKnNn7rpVRYmBAHkTfjzTgMTLUBr+xkPC2I99zA5+T128mJjDxl
         tOV23XR0Sqd1IaBrwGF8Og3LeTK3oW9hOUM/TzamYxA0fVZb9coI+T3tseIYPBcIZW1F
         C1Lrum7/kIfdHa/F4NRRa4VhAPoulQXxs33pDVfLSe8jPyr8yQLrlIRTLLJvti7AtHJ+
         nMQQqwEDMMaZ1WReStLFPBcEEMdd1QIMp5UZon8FwJx7q+p7zjiIWcROnhzc9EZmiyLg
         290k3H1+18D7bj/VFZ87jnaZfAAV2P0/gkt9t5II/ZwkiA7dPlU68kblXZ/XhmJnrSb4
         uugg==
X-Gm-Message-State: APjAAAUdjGdE0riccxyFYInpSb4fFO1Jruq7Djcf68NUgm/uH2Tm1U5w
        GAH24quA/STh0307PR5KJ6LCNvFW
X-Google-Smtp-Source: APXvYqz/HAjAcQJe9Hr3dWO2NAAL0kqeQeIDh5Z/y3bKVL6BhkgLf6hyzpgOLs3MaZoWPYxW6UrVmA==
X-Received: by 2002:a63:774f:: with SMTP id s76mr30994951pgc.187.1580316656667;
        Wed, 29 Jan 2020 08:50:56 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id d4sm3305600pjg.19.2020.01.29.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:50:55 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 30 Jan 2020 01:50:53 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200129165053.GA392@jagdpanzerIV.localdomain>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200128051711.GB115889@google.com>
 <20200128094418.GY32742@smile.fi.intel.com>
 <20200129134141.GA537@jagdpanzerIV.localdomain>
 <20200129142558.GF32742@smile.fi.intel.com>
 <20200129151243.GA488@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129151243.GA488@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/30 00:12), Sergey Senozhatsky wrote:
> On (20/01/29 16:25), Andy Shevchenko wrote:
> > I understand. Seems the ->setup() has to be idempotent. We can tell the same
> > for ->exit() in some comment.
> > 
> > Can you describe, btw, struct console in kernel doc format?
> > It will be very helpful!
> 
> We probably need some documentation.
> 
> > > > In both cases we will get the console to have CON_ENABLED flag set.
> > > 
> > > And there are sneaky consoles that have CON_ENABLED before we even
> > > register them.
> > 
> > So, taking into consideration my comment to the previous patch, what would be
> > suggested guard here?
> > 
> > For a starter something like this?
> > 
> >   if ((console->flags & CON_ENABLED) && console->exit)
> > 	console->exit(console);
> 
> This will work if we also add something like this

No, wait... This will not work, console can be suspended, yet
still registered. I think the only criteria is "the console is
on the list".

	-ss

