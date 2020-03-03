Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18061773E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgCCKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 05:21:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgCCKVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:21:13 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43719214DB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 10:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583230871;
        bh=BZgigy1Ybqp0VibbsbbrFv+s6HWOMTgif2Hm9GI9Rg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MqOIOhq0BIqnxndTGTsAxTPfDgKOyYvXEWflLJFkM4Am6Osxaq67YvxjchMuGQEEI
         DNTGxdNP0UZaQE2GigRpR4bk5LQbuWhmnrHvhNdlWwB+CdTzX6sEtVvXAttvv5fLh4
         YeycHjFm6SPoi5hgfdphd5u/l1S62VSMIxE2Xtao=
Received: by mail-wr1-f54.google.com with SMTP id v4so3585242wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:21:11 -0800 (PST)
X-Gm-Message-State: ANhLgQ2El9tNRMOdBcDOf/NDoPtL2drLsUOP3MEJvD5pnkIz7zt+clUG
        t0midTdlaqFEg5Juqv99+ksacwoznGJRhM6ImQYamg==
X-Google-Smtp-Source: ADFU+vuHpyMhUp1loGgbQGsPP58v4+oqhKFFNGMbiUU9ANUBrEB3+v0EHR+f9xnTbf5pA9obBNpC7YvjfltwmXrKNso=
X-Received: by 2002:adf:a411:: with SMTP id d17mr4735033wra.126.1583230869681;
 Tue, 03 Mar 2020 02:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20200303085528.27658-1-vdronov@redhat.com> <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <1980156503.12639063.1583230452485.JavaMail.zimbra@redhat.com>
In-Reply-To: <1980156503.12639063.1583230452485.JavaMail.zimbra@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 11:20:58 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8MsGU-JXP83Tn2Q_U9JQZV_bkcj7r9JCm__Z3xD7_-uw@mail.gmail.com>
Message-ID: <CAKv+Gu8MsGU-JXP83Tn2Q_U9JQZV_bkcj7r9JCm__Z3xD7_-uw@mail.gmail.com>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 11:14, Vladis Dronov <vdronov@redhat.com> wrote:
>
> Hello, Ard, all,
>
> ----- Original Message -----
> > From: "Ard Biesheuvel" <ardb@kernel.org>
> > To: "Vladis Dronov" <vdronov@redhat.com>
> > Cc: "linux-efi" <linux-efi@vger.kernel.org>, "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
> > Sent: Tuesday, March 3, 2020 10:15:41 AM
> > Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading efivars via sysfs
> >
> > On Tue, 3 Mar 2020 at 09:55, Vladis Dronov <vdronov@redhat.com> wrote:
> > >
> > > There is a race and a buffer overflow corrupting a kernel memory while
> > > reading an efi variable with a size more than 1024 bytes via the older
> > > sysfs method. This happens because accessing struct efi_variable in
> > > efivar_{attr,size,data}_read() and friends is not protected from
> > > a concurrent access leading to a kernel memory corruption and, at best,
> > > to a crash. The race scenario is the following:
> > >
> > > CPU0:                                CPU1:
> > > efivar_attr_read()
> > >   var->DataSize = 1024;
> > >   efivar_entry_get(... &var->DataSize)
> > >     down_interruptible(&efivars_lock)
> > >                                      efivar_attr_read() // same efi var
> > >                                        var->DataSize = 1024;
> > >                                        efivar_entry_get(... &var->DataSize)
> > >                                          down_interruptible(&efivars_lock)
> > >     virt_efi_get_variable()
> > >     // returns EFI_BUFFER_TOO_SMALL but
> > >     // var->DataSize is set to a real
> > >     // var size more than 1024 bytes
> > >     up(&efivars_lock)
> > >                                          virt_efi_get_variable()
> > >                                          // called with var->DataSize set
> > >                                          // to a real var size, returns
> > >                                          // successfully and overwrites
> > >                                          // a 1024-bytes kernel buffer
> > >                                          up(&efivars_lock)
> > >
> > > This can be reproduced by concurrent reading of an efi variable which size
> > > is more than 1024 bytes:
> > >
> > > ts# for cpu in $(seq 0 $(nproc --ignore=1)); do ( taskset -c $cpu \
> > > cat /sys/firmware/efi/vars/KEKDefault*/size & ) ; done
> > >
> > > Fix this by protecting struct efi_variable access by efivars_lock by using
> > > efivar_entry_iter_begin()/efivar_entry_iter_end(). Brush up and unify
> > > efivar_entry_[gs]et() and __efivar_entry_[gs]et() for this. This looks
> > > simpler than introducing a separate lock for every struct efi_variable.
> > >
> > > Also fix the same race in efivar_store_raw() and efivar_show_raw(). The
> > > call in efi_pstore_read_func() is protected like this already.
> > >
> > > Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> > > Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> >
> > Wouldn't it be easier to pass a var_data_size stack variable into
> > efivar_entry_get(), and only update the value in 'var' if it is <=
> > 1024?
> >
>
> I was thinking about this approach, but this way we still do not protect
> var from a concurrent access. For example, efivar_data_read() can race
> with itself:
>
> // reading var size 5
> efivar_data_read()
>   efivar_entry_get()
>                          // reading the same var
>                          efivar_data_read()
>                            var->DataSize = 1024;
>                            efivar_entry_get()
>   // var->DataSize is SUDDENLY 1024
>   memcpy(buf, var->Data, var->DataSize);

I'd assume that the memcpy() is not executed if var_data_size > 1024,
and var->DataSize is not assigned in that case either.

>   return var->DataSize;
>
> Also efivar read functions still can race with the write function
> efivar_store_raw(). Surely, the race window is much smaller but it is there.
> I strongly believe we need to protect all data accesses here with a lock.
>
> May be not in a way I suggest, may be by a per-var mutex, but I believe
> this is overcomplication.
>
> > > ---
> > >  drivers/firmware/efi/efi-pstore.c |  2 +-
> > >  drivers/firmware/efi/efivars.c    | 72 ++++++++++++++++++++++++-------
> > >  drivers/firmware/efi/vars.c       | 47 ++++++++++++--------
> > >  include/linux/efi.h               |  2 +
> > >  4 files changed, 90 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi-pstore.c
> > > b/drivers/firmware/efi/efi-pstore.c
> > > index 9ea13e8d12ec..e4767a7ce973 100644
> > > --- a/drivers/firmware/efi/efi-pstore.c
> > > +++ b/drivers/firmware/efi/efi-pstore.c
> > > @@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct
> > > efivar_entry *pos,
> > >   *
> > >   * @record: pstore record to pass to callback
> > >   *
> > > - * You MUST call efivar_enter_iter_begin() before this function, and
> > > + * You MUST call efivar_entry_iter_begin() before this function, and
> > >   * efivar_entry_iter_end() afterwards.
> > >   *
> > >   */
> > > diff --git a/drivers/firmware/efi/efivars.c
> > > b/drivers/firmware/efi/efivars.c
> > > index 7576450c8254..f415cf863ee0 100644
> > > --- a/drivers/firmware/efi/efivars.c
> > > +++ b/drivers/firmware/efi/efivars.c
> > > @@ -88,9 +88,15 @@ efivar_attr_read(struct efivar_entry *entry, char *buf)
> > >         if (!entry || !buf)
> > >                 return -EINVAL;
> > >
> > > +       if (efivar_entry_iter_begin())
> > > +               return -EINTR;
> > > +
> > >         var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > var->Data))
> > > +       if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > +                       var->Data)) {
> > > +               efivar_entry_iter_end();
> > >                 return -EIO;
> > > +       }
> > >
> > >         if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
> > >                 str += sprintf(str, "EFI_VARIABLE_NON_VOLATILE\n");
> > > @@ -109,6 +115,8 @@ efivar_attr_read(struct efivar_entry *entry, char *buf)
> > >                         "EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS\n");
> > >         if (var->Attributes & EFI_VARIABLE_APPEND_WRITE)
> > >                 str += sprintf(str, "EFI_VARIABLE_APPEND_WRITE\n");
> > > +
> > > +       efivar_entry_iter_end();
> > >         return str - buf;
> > >  }
> > >
> > > @@ -121,11 +129,19 @@ efivar_size_read(struct efivar_entry *entry, char
> > > *buf)
> > >         if (!entry || !buf)
> > >                 return -EINVAL;
> > >
> > > +       if (efivar_entry_iter_begin())
> > > +               return -EINTR;
> > > +
> > >         var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > var->Data))
> > > +       if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > +                       var->Data)) {
> > > +               efivar_entry_iter_end();
> > >                 return -EIO;
> > > +       }
> > >
> > >         str += sprintf(str, "0x%lx\n", var->DataSize);
> > > +
> > > +       efivar_entry_iter_end();
> > >         return str - buf;
> > >  }
> > >
> > > @@ -137,11 +153,19 @@ efivar_data_read(struct efivar_entry *entry, char
> > > *buf)
> > >         if (!entry || !buf)
> > >                 return -EINVAL;
> > >
> > > +       if (efivar_entry_iter_begin())
> > > +               return -EINTR;
> > > +
> > >         var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > var->Data))
> > > +       if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > +                       var->Data)) {
> > > +               efivar_entry_iter_end();
> > >                 return -EIO;
> > > +       }
> > >
> > >         memcpy(buf, var->Data, var->DataSize);
> > > +
> > > +       efivar_entry_iter_end();
> > >         return var->DataSize;
> > >  }
> > >
> > > @@ -197,13 +221,21 @@ efivar_store_raw(struct efivar_entry *entry, const
> > > char *buf, size_t count)
> > >         efi_guid_t vendor;
> > >         u32 attributes;
> > >         u8 *data;
> > > -       int err;
> > > +       int err = 0;
> > > +
> > > +       if (!entry || !buf)
> > > +               return -EINVAL;
> > > +
> > > +       if (efivar_entry_iter_begin())
> > > +               return -EINTR;
> > >
> > >         if (in_compat_syscall()) {
> > >                 struct compat_efi_variable *compat;
> > >
> > > -               if (count != sizeof(*compat))
> > > -                       return -EINVAL;
> > > +               if (count != sizeof(*compat)) {
> > > +                       err = -EINVAL;
> > > +                       goto out;
> > > +               }
> > >
> > >                 compat = (struct compat_efi_variable *)buf;
> > >                 attributes = compat->Attributes;
> > > @@ -214,12 +246,14 @@ efivar_store_raw(struct efivar_entry *entry, const
> > > char *buf, size_t count)
> > >
> > >                 err = sanity_check(var, name, vendor, size, attributes,
> > >                 data);
> > >                 if (err)
> > > -                       return err;
> > > +                       goto out;
> > >
> > >                 copy_out_compat(&entry->var, compat);
> > >         } else {
> > > -               if (count != sizeof(struct efi_variable))
> > > -                       return -EINVAL;
> > > +               if (count != sizeof(struct efi_variable)) {
> > > +                       err = -EINVAL;
> > > +                       goto out;
> > > +               }
> > >
> > >                 new_var = (struct efi_variable *)buf;
> > >
> > > @@ -231,18 +265,20 @@ efivar_store_raw(struct efivar_entry *entry, const
> > > char *buf, size_t count)
> > >
> > >                 err = sanity_check(var, name, vendor, size, attributes,
> > >                 data);
> > >                 if (err)
> > > -                       return err;
> > > +                       goto out;
> > >
> > >                 memcpy(&entry->var, new_var, count);
> > >         }
> > >
> > > -       err = efivar_entry_set(entry, attributes, size, data, NULL);
> > > +       err = __efivar_entry_set(entry, attributes, size, data, NULL);
> > >         if (err) {
> > >                 printk(KERN_WARNING "efivars: set_variable() failed:
> > >                 status=%d\n", err);
> > > -               return -EIO;
> > > +               err = -EIO;
> > >         }
> > >
> > > -       return count;
> > > +out:
> > > +       efivar_entry_iter_end();
> > > +       return err ?: count;
> > >  }
> > >
> > >  static ssize_t
> > > @@ -255,10 +291,15 @@ efivar_show_raw(struct efivar_entry *entry, char
> > > *buf)
> > >         if (!entry || !buf)
> > >                 return 0;
> > >
> > > +       if (efivar_entry_iter_begin())
> > > +               return -EINTR;
> > > +
> > >         var->DataSize = 1024;
> > > -       if (efivar_entry_get(entry, &entry->var.Attributes,
> > > -                            &entry->var.DataSize, entry->var.Data))
> > > +       if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> > > +                       var->Data)) {
> > > +               efivar_entry_iter_end();
> > >                 return -EIO;
> > > +       }
> > >
> > >         if (in_compat_syscall()) {
> > >                 compat = (struct compat_efi_variable *)buf;
> > > @@ -276,6 +317,7 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
> > >                 memcpy(buf, var, size);
> > >         }
> > >
> > > +       efivar_entry_iter_end();
> > >         return size;
> > >  }
> > >
> > > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > > index 436d1776bc7b..4a47e20a7667 100644
> > > --- a/drivers/firmware/efi/vars.c
> > > +++ b/drivers/firmware/efi/vars.c
> > > @@ -636,7 +636,7 @@ int efivar_entry_delete(struct efivar_entry *entry)
> > >  EXPORT_SYMBOL_GPL(efivar_entry_delete);
> > >
> > >  /**
> > > - * efivar_entry_set - call set_variable()
> > > + * __efivar_entry_set - call set_variable()
> > >   * @entry: entry containing the EFI variable to write
> > >   * @attributes: variable attributes
> > >   * @size: size of @data buffer
> > > @@ -655,8 +655,12 @@ EXPORT_SYMBOL_GPL(efivar_entry_delete);
> > >   * Returns 0 on success, -EINTR if we can't grab the semaphore,
> > >   * -EEXIST if a lookup is performed and the entry already exists on
> > >   * the list, or a converted EFI status code if set_variable() fails.
> > > + *
> > > + * The caller MUST call efivar_entry_iter_begin() and
> > > + * efivar_entry_iter_end() before and after the invocation of this
> > > + * function, respectively.
> > >   */
> > > -int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> > > +int __efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> > >                      unsigned long size, void *data, struct list_head
> > >                      *head)
> > >  {
> > >         const struct efivar_operations *ops;
> > > @@ -664,9 +668,6 @@ int efivar_entry_set(struct efivar_entry *entry, u32
> > > attributes,
> > >         efi_char16_t *name = entry->var.VariableName;
> > >         efi_guid_t vendor = entry->var.VendorGuid;
> > >
> > > -       if (down_interruptible(&efivars_lock))
> > > -               return -EINTR;
> > > -
> > >         if (!__efivars) {
> > >                 up(&efivars_lock);
> > >                 return -EINVAL;
> > > @@ -682,10 +683,28 @@ int efivar_entry_set(struct efivar_entry *entry, u32
> > > attributes,
> > >                 status = ops->set_variable(name, &vendor,
> > >                                            attributes, size, data);
> > >
> > > -       up(&efivars_lock);
> > > -
> > >         return efi_status_to_err(status);
> > > +}
> > > +EXPORT_SYMBOL_GPL(__efivar_entry_set);
> > >
> > > +/**
> > > + * efivar_entry_set - call set_variable()
> > > + *
> > > + * This function takes efivars_lock and calls __efivar_entry_set()
> > > + */
> > > +int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> > > +                    unsigned long size, void *data, struct list_head
> > > *head)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (down_interruptible(&efivars_lock))
> > > +               return -EINTR;
> > > +
> > > +       ret = __efivar_entry_set(entry, attributes, size, data, head);
> > > +
> > > +       up(&efivars_lock);
> > > +
> > > +       return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(efivar_entry_set);
> > >
> > > @@ -914,22 +933,16 @@ EXPORT_SYMBOL_GPL(__efivar_entry_get);
> > >  int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
> > >                      unsigned long *size, void *data)
> > >  {
> > > -       efi_status_t status;
> > > +       int ret;
> > >
> > >         if (down_interruptible(&efivars_lock))
> > >                 return -EINTR;
> > >
> > > -       if (!__efivars) {
> > > -               up(&efivars_lock);
> > > -               return -EINVAL;
> > > -       }
> > > +       ret = __efivar_entry_get(entry, attributes, size, data);
> > >
> > > -       status = __efivars->ops->get_variable(entry->var.VariableName,
> > > -                                             &entry->var.VendorGuid,
> > > -                                             attributes, size, data);
> > >         up(&efivars_lock);
> > >
> > > -       return efi_status_to_err(status);
> > > +       return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(efivar_entry_get);
> > >
> > > @@ -1071,7 +1084,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
> > >   * entry on the list. It is safe for @func to remove entries in the
> > >   * list via efivar_entry_delete().
> > >   *
> > > - * You MUST call efivar_enter_iter_begin() before this function, and
> > > + * You MUST call efivar_entry_iter_begin() before this function, and
> > >   * efivar_entry_iter_end() afterwards.
> > >   *
> > >   * It is possible to begin iteration from an arbitrary entry within
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index 7efd7072cca5..5c3db088d375 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -1414,6 +1414,8 @@ int __efivar_entry_get(struct efivar_entry *entry,
> > > u32 *attributes,
> > >                        unsigned long *size, void *data);
> > >  int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
> > >                      unsigned long *size, void *data);
> > > +int __efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> > > +                    unsigned long size, void *data, struct list_head
> > > *head);
> > >  int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> > >                      unsigned long size, void *data, struct list_head
> > >                      *head);
> > >  int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
> > > --
> > > 2.20.1
>
