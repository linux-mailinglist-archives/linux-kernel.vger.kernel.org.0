Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407668EC12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfHOMzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 08:55:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33814 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbfHOMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:55:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so1317486pfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhKPSZDVWn3A3XDlmv5lKH3S+rSwgkaMkAzuide4U6c=;
        b=dTzLqWJLqLnldTjV/qF2o+fRFCEUKbeqUmCb/6a4UVgjZVoovbZhXXlRomql/u9Zrs
         qWWahhLEeco+4u620TNFFihMF9fIsRb1XZIbUzvB0FUgMe5xJj+i9lQv/DyO4GSC747h
         rUBbTkF5nbW63c70PpEWdRhpxm4IKzMKRz9pC2wcMNgrLlh4+JT6nnMv30RHYG92STcm
         lMi4ZVamOnLZxK4kgr/wIlpAfReN1SqFRSHn4t3UxJEsFv6uWtE+3CitUhs6T2ANitYf
         Orc2ybS07OIIWe8zMcE6v6sz3fFnGqOSXVTJopNzvByMxv0FPmxDuJ+aFIk5f/AXECBl
         QFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhKPSZDVWn3A3XDlmv5lKH3S+rSwgkaMkAzuide4U6c=;
        b=AMUVBA6CqylROhsYyMWfDDnsyvQqwu8lDId1bDs2JOQSjKv2tm9J2HCUnsQTGUl70C
         RclAxdJ/bOh1kg/9kG3lOJsUi3hSfPGK8G2L+e/7zGBfDHXm27JsYK6Pm4igbAZpMfB1
         UJrHRdiZHF0MTmH3qSyYU4zsZPI+yYZMEMkbbrOU75A13G2C45LYXdJSM1o/B7Y7J1op
         HvpRr1/aOwz2mjmUjBbdrctCep27D0dwRrLrRPKnPs/yGxl0NGmXZ7maUAuZ/BPCLBEH
         xy2jXFfb11JRSsKkMPaxwtWS2r3xOVGFKN7uBuTRw5LapGO3bDVoQD/fmvS3sQb+ualg
         R/qg==
X-Gm-Message-State: APjAAAUH8T/MKFEQtCtFeIgPjeElk2hPHMVK8ey+YGsx1m9B77rn9/ZB
        M30ihPIeZcySDzcysaXEyP8NS2EpSJJhf4qqBjoshtSr
X-Google-Smtp-Source: APXvYqw+u0QrQpW4pVFzpwmszKfRiGZC4dqf4yJh8PxqpU2e9BitZh1bdQTm2tUFbm8lhrE82cBkYbyXRy8NQAC4Ae8=
X-Received: by 2002:a62:7503:: with SMTP id q3mr5442611pfc.151.1565873751923;
 Thu, 15 Aug 2019 05:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190815112826.81785-1-heikki.krogerus@linux.intel.com> <20190815112826.81785-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190815112826.81785-2-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Aug 2019 15:55:40 +0300
Message-ID: <CAHp75VduJ2VQ-4r-vrARMyL6WAnsppwMtLRD-g4f-GEnew8m2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] software node: Add software_node_find_by_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:32 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Function that searches software nodes by node name.

> +/**
> + * software_node_find_by_name - Find software node by name
> + * @parent: Parent of the software node
> + * @name: Name of the software node
> + *
> + * The function will find a node that is child of @parent and that is named
> + * @name. If no node is found, the function returns NULL.

Shouldn't we add that the caller responsible of putting kobject?

> + */
> +const struct software_node *
> +software_node_find_by_name(const struct software_node *parent, const char *name)
> +{
> +       struct swnode *swnode;
> +       struct kobject *k;
> +
> +       if (!name)
> +               return NULL;
> +
> +       spin_lock(&swnode_kset->list_lock);
> +
> +       list_for_each_entry(k, &swnode_kset->list, entry) {
> +               swnode = kobj_to_swnode(k);
> +               if (parent == swnode->node->parent && swnode->node->name &&
> +                   !strcmp(name, swnode->node->name)) {
> +                       kobject_get(&swnode->kobj);
> +                       break;
> +               }
> +               swnode = NULL;
> +       }
> +
> +       spin_unlock(&swnode_kset->list_lock);
> +
> +       return swnode ? swnode->node : NULL;
> +}
> +EXPORT_SYMBOL_GPL(software_node_find_by_name);
> +
>  static int
>  software_node_register_properties(struct software_node *node,
>                                   const struct property_entry *properties)
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 5a910ad79591..9b3d4ca3a73a 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -421,6 +421,10 @@ bool is_software_node(const struct fwnode_handle *fwnode);
>  const struct software_node *to_software_node(struct fwnode_handle *fwnode);
>  struct fwnode_handle *software_node_fwnode(const struct software_node *node);
>
> +const struct software_node *
> +software_node_find_by_name(const struct software_node *parent,
> +                          const char *name);
> +
>  int software_node_register_nodes(const struct software_node *nodes);
>  void software_node_unregister_nodes(const struct software_node *nodes);
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
