Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742DC18ACC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 07:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCSG0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 02:26:38 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39896 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgCSG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 02:26:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tt04BxJ_1584599154;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tt04BxJ_1584599154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Mar 2020 14:25:54 +0800
Subject: Re: [PATCH v2] Translate Documentation/filesystems/debugfs.txt into
 Chinese
To:     Chucheng Luo <luochucheng@vivo.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200319030039.29006-1-luochucheng@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <21d534e9-e7f6-f3ed-c7cc-0fd3691ad679@linux.alibaba.com>
Date:   Thu, 19 Mar 2020 14:25:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319030039.29006-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2020/3/19 ����11:00, Chucheng Luo д��:
> Translate debugfs.txt into Chinese and link it to the index.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> Acked-by: Jonathan Corbet<corbet@lwn.net>
> ---
>  .../zh_CN/filesystems/debugfs.rst             | 257 ++++++++++++++++++
>  .../translations/zh_CN/filesystems/index.rst  |  19 ++
>  Documentation/translations/zh_CN/index.rst    |   1 +
>  3 files changed, 277 insertions(+)
>  create mode 100755 Documentation/translations/zh_CN/filesystems/debugfs.rst
>  create mode 100755 Documentation/translations/zh_CN/filesystems/index.rst
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> new file mode 100755
> index 000000000000..02f639445d3d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> @@ -0,0 +1,257 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/debugfs.txt<debugfs_index>`
> +
> +==========================
> +Debugfs
> +==========================
> +
> +����
> +::
> +
> +	���İ�ά���ߣ� �޳��� Chucheng Luo <luochucheng@vivo.com>
> +	���İ淭���ߣ� �޳��� Chucheng Luo <luochucheng@vivo.com>
> +	���İ�У����:  �޳��� Chucheng Luo <luochucheng@vivo.com>
> +
> +
> +
> +
> +��Ȩ����2009 Jonathan Corbet <corbet@lwn.net>
> +
> +����
> +====
> +
> +Debugfs���ں˿�����Ա���û��ռ��ȡ��Ϣ�ļ򵥷�����
> +��/proc��ͬ��procֻ�ṩ������Ϣ��Ҳ����sysfs,�����ϸ�ġ�ÿ���ļ�һ��ֵ���Ĺ���
> +debugfs����û�й��򡣿�����Ա���Է���������Ҫ���κ���Ϣ�����
> +debugfs�ļ�ϵͳҲ���������ȶ���

Could we follow 80 chars rule here and all following?


> +ABI�ӿڵ��û��ռ䣻�������Ͻ����ļ���debugfs�ﵼ��û���κ��ȶ��Ե�Լ����
> +����[1]��ʵ���粢��������ô�򵥡�
> +��ʹ��debugfs�ӿڣ�Ҳ��ø�����Ҫ�������
> +��Զ������ȥ��

It's hard to understand in Chinese here.
 
> +
> +�÷�
> +====
> +
> +Debugfsͨ��ʹ���������װ::
> +
> +    mount -t debugfs none /sys/kernel/debug
> +
> +�����Ч��/etc/fstab�У���
> +debugfs��Ŀ¼Ĭ�Ͻ�����root�û����ʡ�
> +Ҫ���Ķ����ķ��ʣ���ʹ�á� uid������ gid���͡� mode������ѡ�
> +
> +��ע�⣬debugfs API������ΪGPL��ģ�顣
> +
> +ʹ��debugfs�Ĵ���Ӧ����<linux/debugfs.h>��Ȼ�󣬵�һ��
> +ҵ���Ǵ�������һ��Ŀ¼������һ��debugfs�ļ�::
> +
> +    struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
> +
> +����ɹ����˵��ý���ָ���ĸ�Ŀ¼Ŀ¼�´���һ����Ϊname��Ŀ¼��
> +���parentΪNULL����Ŀ¼Ϊ
> +��debugfs��Ŀ¼�д������ɹ�ʱ������ֵ��һ���ṹ
> +dentryָ�룬��������Ŀ¼�д����ļ����Լ�
> +���������ɾ����� ERR_PTR��-ERROR������ֵ��������������ERR_PTR��-ENODEV������Ϊ
> +�����ں�����û��debugfs֧�ֵ�����¹����ģ������������������������á�
> +
> +��debugfsĿ¼�д����ļ�����ͨ�÷�����::
> +
> +    struct dentry *debugfs_create_file(const char *name, umode_t mode,
> +				       struct dentry *parent, void *data,
> +				       const struct file_operations *fops);
> +
> +�����name��Ҫ�������ļ������ƣ�mode�����˷���
> +�ļ�Ӧ���е�Ȩ�ޣ�parentָ��Ӧ�ñ����ļ���Ŀ¼
> +��data���洢�ڲ�����inode�ṹ��i_private�ֶ���
> +����fops��һ���ļ�����������
> +ʵ���ļ�����Ϊ�����٣�read������/��write����
> +����Ӧ�ṩ���������Ը�����Ҫ�������ڡ��ٴΣ�
> +����ֵ����ָ�򴴽��ļ���dentryָ�룬
> +����ʱ��ʾERR_PTR��-ERROR������֧��debugfsʱ����ֵΪERR_PTR��-ENODEV����
> +
> +����һ����ʼ��С���ļ�������ʹ�����º�������::
> +
> +    struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
> +				struct dentry *parent, void *data,
> +				const struct file_operations *fops,
> +				loff_t file_size);
> +
> +file_size�ǳ�ʼ�ļ���С����������������debugfs_create_file����ͬ��
> +
> +���������£�����һ���ļ���������
> +ʵ�ʱ�Ҫ�ģ�

Change to "û��ʵ�ʱ�Ҫȥ����һ���ļ�����" ?

Chinese often has different words sequence from English in sentence.  
Please pay attention on this.
 
���ڼ򵥵������debugfs�����ṩ������������
> +��������������ֵ���ļ�����ʹ�������κ�һ���::
> +
> +    void debugfs_create_u8(const char *name, umode_t mode,
> +			   struct dentry *parent, u8 *value);
> +    void debugfs_create_u16(const char *name, umode_t mode,
> +			    struct dentry *parent, u16 *value);
> +    struct dentry *debugfs_create_u32(const char *name, umode_t mode,
> +				      struct dentry *parent, u32 *value);
> +    void debugfs_create_u64(const char *name, umode_t mode,
> +			    struct dentry *parent, u64 *value);
> +
> +��Щ�ļ�֧�ֶ�ȡ��д�����ֵ���������
> +��Ӧд���ļ���ֻ����Ӧ������ģʽλ����
> +��Щ�ļ��е�ֵ��ʮ���Ʊ�ʾ�����ʮ�����Ƹ����ʣ�
> +����ʹ�����¹���::
> +
> +    void debugfs_create_x8(const char *name, umode_t mode,
> +			   struct dentry *parent, u8 *value);
> +    void debugfs_create_x16(const char *name, umode_t mode,
> +			    struct dentry *parent, u16 *value);
> +    void debugfs_create_x32(const char *name, umode_t mode,
> +			    struct dentry *parent, u32 *value);
> +    void debugfs_create_x64(const char *name, umode_t mode,
> +			    struct dentry *parent, u64 *value);
> +
> +ֻҪ������Ա֪������ֵ�Ĵ�С����Щ���ܾͺ����á�
> +ĳЩ�����ڲ�ͬ�ļܹ��Ͽ��Ծ��в�ͬ�Ŀ��
> +���ǣ�������ʹ��������Щ���ӡ���
> +��������������¿����ṩ�����Ĺ���::
> +
> +    void debugfs_create_size_t(const char *name, umode_t mode,
> +			       struct dentry *parent, size_t *value);
> +
> +�������ϣ��˺���������һ��debugfs�ļ�����ʾ
> +����Ϊsize_t�ı�����
> +
> +ͬ���أ�Ҳ���޷��ų������ͱ��������֣���ʮ���Ʊ�ʾ
> +��ʮ������::
> +
> +    struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
> +					struct dentry *parent,
> +					unsigned long *value);
> +    void debugfs_create_xul(const char *name, umode_t mode,
> +			    struct dentry *parent, unsigned long *value);
> +
> +����ֵ����ͨ�����·�ʽ������debugfs��::
> +
> +    struct dentry *debugfs_create_bool(const char *name, umode_t mode,
> +				       struct dentry *parent, bool *value);
> +
> +
> +��ȡ����ļ�������Y�����ڷ���ֵ����
> +N��������з������д�룬�������ܴ�д��
> +Сдֵ��1��0���κ��������뽫�����ԡ�
> +
> +ͬ��������ʹ���������atomic_tֵ������debugfs��::
> +
> +    void debugfs_create_atomic_t(const char *name, umode_t mode,
> +				 struct dentry *parent, atomic_t *value)
> +
> +��ȡ���ļ������atomic_tֵ����д����ļ�
> +������atomic_tֵ��
> +
> +��һ��ѡ���ǵ���һ��������������ݿ飬
> +����ṹ�͹���::
> +
> +    struct debugfs_blob_wrapper {
> +	void *data;
> +	unsigned long size;
> +    };
> +
> +    struct dentry *debugfs_create_blob(const char *name, umode_t mode,
> +				       struct dentry *parent,
> +				       struct debugfs_blob_wrapper *blob);
> +
> +��ȡ���ļ���������ָ��ָ��debugfs_blob_wrapper�ṹ
> +�����ݡ�һЩ����ʹ�á�blobs����Ϊһ�ּ򵥵ķ���
> +���ؼ��У���̬����ʽ���ı�������������
> +�����ڵ�����������Ϣ�����ƺ�û��
> +��������ִ�д˲������κδ��롣��ע�⣬ʹ��debugfs_create_blob����������������ļ�
> +��ֻ���ġ�
> +
> +�����Ҫת��һ���Ĵ����飨�����������൱
> +ͨ���ڿ��������У���ʹ�����������Ĵ��뵽�����ߡ�
> +Debugfs�ṩ�������ܣ�һ�����ڴ������Ĵ����ļ�����һ��
> +��һ���Ĵ��������һ��˳���ļ���::
> +
> +    struct debugfs_reg32 {
> +	char *name;
> +	unsigned long offset;
> +    };
> +
> +    struct debugfs_regset32 {
> +	struct debugfs_reg32 *regs;
> +	int nregs;
> +	void __iomem *base;
> +    };
> +
> +    struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
> +				     struct dentry *parent,
> +				     struct debugfs_regset32 *regset);
> +
> +    void debugfs_print_regs32(struct seq_file *s, struct debugfs_reg32 *regs,
> +			 int nregs, void __iomem *base, char *prefix);
> +
> +��base����������Ϊ0������������Ҫ����reg32����
> +ʹ��__stringify��ʵ���������Ĵ������ƣ��꣩
> +�Ĵ�����Ļ�ַ�ϵ��ֽ�ƫ������
> +
> +���Ҫ��debugfs��ת��u32���飬����ʹ������������ļ�::
> +
> +     void debugfs_create_u32_array(const char *name, umode_t mode,
> +			struct dentry *parent,
> +			u32 *array, u32 elements);
> +
> +��array�������ṩ���ݣ�����elements������Ϊ
> +������Ԫ�ص�������ע�⣺���������
> +��С�޷����ġ�
> +
> +��һ�������������������豸��ص�seq_file::
> +
> +   struct dentry *debugfs_create_devm_seqfile(struct device *dev,
> +				const char *name,
> +				struct dentry *parent,
> +				int (*read_fn)(struct seq_file *s,
> +					void *data));
> +
> +��dev�����������debugfs�ļ���ص��豸������
> +��read_fn����һ������ָ�룬���������Դ�ӡ
> +seq_file���ݡ�
> +
> +����һЩ����������Ŀ¼�İ���������::
> +
> +    struct dentry *debugfs_rename(struct dentry *old_dir,
> +		                  struct dentry *old_dentry,
> +		                  struct dentry *new_dir,
> +				  const char *new_name);
> +
> +    struct dentry *debugfs_create_symlink(const char *name,
> +                                          struct dentry *parent,
> +                                          const char *target);
> +
> +����debugfs_rename()��Ϊ���е�debugfs�ļ��ṩһ�������ƣ�
> +����������Ŀ¼�С� new_name��������֮ǰ���ܴ��ڣ�
> +����ֵΪold_dentry�����а������µ���Ϣ��
> +����ʹ��debugfs_create_symlink���������������ӡ�
> +
> +����debugfs�û����뿼�ǵ�һ�����ǣ�
> +û���Զ������debugfs�д������κ�Ŀ¼�����һ��
> +�ڲ���ʽɾ��debugfs��Ŀ�������ж��ģ�飬���
> +�����кܶ�¾ɵ�ָ�룬��û��û�˵ĸ߶ȷ������Ϊ��

it's hard to understand.


> +��ˣ�����debugfs�û�-��������Щ������Ϊģ�鹹�����û�-����
> +׼��ɾ���ڴ˴����������ļ���Ŀ¼��һ���ļ�
> +����ͨ�����·�ʽɾ��::
> +
> +    void debugfs_remove(struct dentry *dentry);
> +
> +dentryֵ����ΪNULL�����ֵ������������£��������κν��
> +��ɾ����
> +
> +��ǰ��debugfs�û���Ҫ��ס��dentry
> +���Ǵ�����ÿ��debugfs�ļ���ָ�룬�Ա������ļ�������

Could you understand this?

> +�������ǣ��������������ڸ���������ʱ��������debugfs�û�
> +�ܵ���::
> +
> +    void debugfs_remove_recursive(struct dentry *dentry);
> +
> +��������˴˺��������Ӧ��
> +����Ŀ¼����Ŀ¼�µ�������νṹ���ᱻɾ����
> +
> +ע�⣺
> +[1] http://lwn.net/Articles/309298/
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
> new file mode 100755
> index 000000000000..79b6c20f9575
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -0,0 +1,19 @@
> +===============================
> +Linux �ں��е��ļ�ϵͳ
> +===============================
> +
> +�����������ָ����ĳһ�콫���ṩ����Linux �����ļ�ϵͳ(VFS)����ι�����
> +������Ϣ���Լ�VFS���µĵ��ļ�ϵͳ��ĿǰΪֹ�������ṩ��������Ϣ��
> +
> +
> +
> +
> +�ļ�ϵͳ
> +===========
> +
> +�����ļ�ϵͳʵ�ֵ��ĵ�.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   debugfs
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index d3165535ec9e..76850a5dd982 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -14,6 +14,7 @@
>     :maxdepth: 2
>  
>     process/index
> +   filesystems/index
>  
>  Ŀ¼�ͱ��
>  ----------
> 
