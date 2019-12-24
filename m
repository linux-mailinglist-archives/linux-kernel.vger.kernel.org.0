Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6F12A2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLXPMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 10:12:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfLXPLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:00 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186A720731;
        Tue, 24 Dec 2019 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200258;
        bh=LjUzR8Y0jKypj0DdCNeEpWVZX84KzMQ5NTCvsuD+PnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qR3az+jy6tX+1BcfcT1auB1BMSmT4nCx/qpcaDnYkrBdrLEzRIOq09/gyX7yyxV5M
         U3/1KgI60pI477oRFAWnVoIuG0RQL7XsoIIF8ELuY7vyZzeR4zEHO11dPn5WqA1OUj
         u9KYlIIBg6XwwJg3lAQgAeC3PPm0MePpIeID+RJQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 08/25] efi/libstub: extend native protocol definitions with mixed_mode aliases
Date:   Tue, 24 Dec 2019 16:10:08 +0100
Message-Id: <20191224151025.32482-9-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of moving to a native vs. mixed mode split rather than a
32 vs. 64 bit split when it comes to invoking EFI firmware services,
update all the native protocol definitions and redefine them as unions
containing an anonymous struct for the native view and a struct called
'mixed_mode' describing the 32-bit view of the protocol when called from
64-bit code.

While at it, flesh out some PCI I/O member definitions that we will be
needing shortly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.h        |  15 +-
 drivers/firmware/efi/libstub/arm-stub.c |   4 +-
 drivers/firmware/efi/libstub/random.c   |  22 +-
 include/linux/efi.h                     | 496 ++++++++++++++++--------
 4 files changed, 357 insertions(+), 180 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index 8297387c4676..26f1f2635f64 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -24,10 +24,17 @@ typedef struct {
 	u64 blt;
 } efi_uga_draw_protocol_64_t;
 
-typedef struct {
-	void *get_mode;
-	void *set_mode;
-	void *blt;
+typedef union {
+	struct {
+		void *get_mode;
+		void *set_mode;
+		void *blt;
+	};
+	struct {
+		u32 get_mode;
+		u32 set_mode;
+		u32 blt;
+	} mixed_mode;
 } efi_uga_draw_protocol_t;
 
 #endif /* BOOT_COMPRESSED_EBOOT_H */
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 817237ce2420..60a301e1c072 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -40,9 +40,9 @@ static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 void efi_char16_printk(efi_system_table_t *sys_table_arg,
 			      efi_char16_t *str)
 {
-	struct efi_simple_text_output_protocol *out;
+	efi_simple_text_output_protocol_t *out;
 
-	out = (struct efi_simple_text_output_protocol *)sys_table_arg->con_out;
+	out = (efi_simple_text_output_protocol_t *)sys_table_arg->con_out;
 	out->output_string(out, str);
 }
 
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 97378cf96a2e..d92cd640c73d 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -9,7 +9,7 @@
 
 #include "efistub.h"
 
-typedef struct efi_rng_protocol efi_rng_protocol_t;
+typedef union efi_rng_protocol efi_rng_protocol_t;
 
 typedef struct {
 	u32 get_info;
@@ -21,11 +21,17 @@ typedef struct {
 	u64 get_rng;
 } efi_rng_protocol_64_t;
 
-struct efi_rng_protocol {
-	efi_status_t (*get_info)(struct efi_rng_protocol *,
-				 unsigned long *, efi_guid_t *);
-	efi_status_t (*get_rng)(struct efi_rng_protocol *,
-				efi_guid_t *, unsigned long, u8 *out);
+union efi_rng_protocol {
+	struct {
+		efi_status_t (*get_info)(efi_rng_protocol_t *,
+					 unsigned long *, efi_guid_t *);
+		efi_status_t (*get_rng)(efi_rng_protocol_t *,
+					efi_guid_t *, unsigned long, u8 *out);
+	};
+	struct {
+		u32 get_info;
+		u32 get_rng;
+	} mixed_mode;
 };
 
 efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
@@ -33,7 +39,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_status_t status;
-	struct efi_rng_protocol *rng = NULL;
+	efi_rng_protocol_t *rng = NULL;
 
 	status = efi_call_early(locate_protocol, &rng_proto, NULL,
 				(void **)&rng);
@@ -162,7 +168,7 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
-	struct efi_rng_protocol *rng = NULL;
+	efi_rng_protocol_t *rng = NULL;
 	struct linux_efi_random_seed *seed = NULL;
 	efi_status_t status;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8d267715ce22..5a220af263b1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -315,55 +315,58 @@ typedef struct {
 /*
  * EFI Boot Services table
  */
-typedef struct {
-	efi_table_hdr_t hdr;
-	void *raise_tpl;
-	void *restore_tpl;
-	efi_status_t (*allocate_pages)(int, int, unsigned long,
-				       efi_physical_addr_t *);
-	efi_status_t (*free_pages)(efi_physical_addr_t, unsigned long);
-	efi_status_t (*get_memory_map)(unsigned long *, void *, unsigned long *,
-				       unsigned long *, u32 *);
-	efi_status_t (*allocate_pool)(int, unsigned long, void **);
-	efi_status_t (*free_pool)(void *);
-	void *create_event;
-	void *set_timer;
-	void *wait_for_event;
-	void *signal_event;
-	void *close_event;
-	void *check_event;
-	void *install_protocol_interface;
-	void *reinstall_protocol_interface;
-	void *uninstall_protocol_interface;
-	efi_status_t (*handle_protocol)(efi_handle_t, efi_guid_t *, void **);
-	void *__reserved;
-	void *register_protocol_notify;
-	efi_status_t (*locate_handle)(int, efi_guid_t *, void *,
-				      unsigned long *, efi_handle_t *);
-	void *locate_device_path;
-	efi_status_t (*install_configuration_table)(efi_guid_t *, void *);
-	void *load_image;
-	void *start_image;
-	void *exit;
-	void *unload_image;
-	efi_status_t (*exit_boot_services)(efi_handle_t, unsigned long);
-	void *get_next_monotonic_count;
-	void *stall;
-	void *set_watchdog_timer;
-	void *connect_controller;
-	void *disconnect_controller;
-	void *open_protocol;
-	void *close_protocol;
-	void *open_protocol_information;
-	void *protocols_per_handle;
-	void *locate_handle_buffer;
-	efi_status_t (*locate_protocol)(efi_guid_t *, void *, void **);
-	void *install_multiple_protocol_interfaces;
-	void *uninstall_multiple_protocol_interfaces;
-	void *calculate_crc32;
-	void *copy_mem;
-	void *set_mem;
-	void *create_event_ex;
+typedef union {
+	struct {
+		efi_table_hdr_t hdr;
+		void *raise_tpl;
+		void *restore_tpl;
+		efi_status_t (*allocate_pages)(int, int, unsigned long,
+					       efi_physical_addr_t *);
+		efi_status_t (*free_pages)(efi_physical_addr_t, unsigned long);
+		efi_status_t (*get_memory_map)(unsigned long *, void *, unsigned long *,
+					       unsigned long *, u32 *);
+		efi_status_t (*allocate_pool)(int, unsigned long, void **);
+		efi_status_t (*free_pool)(void *);
+		void *create_event;
+		void *set_timer;
+		void *wait_for_event;
+		void *signal_event;
+		void *close_event;
+		void *check_event;
+		void *install_protocol_interface;
+		void *reinstall_protocol_interface;
+		void *uninstall_protocol_interface;
+		efi_status_t (*handle_protocol)(efi_handle_t, efi_guid_t *, void **);
+		void *__reserved;
+		void *register_protocol_notify;
+		efi_status_t (*locate_handle)(int, efi_guid_t *, void *,
+					      unsigned long *, efi_handle_t *);
+		void *locate_device_path;
+		efi_status_t (*install_configuration_table)(efi_guid_t *, void *);
+		void *load_image;
+		void *start_image;
+		void *exit;
+		void *unload_image;
+		efi_status_t (*exit_boot_services)(efi_handle_t, unsigned long);
+		void *get_next_monotonic_count;
+		void *stall;
+		void *set_watchdog_timer;
+		void *connect_controller;
+		void *disconnect_controller;
+		void *open_protocol;
+		void *close_protocol;
+		void *open_protocol_information;
+		void *protocols_per_handle;
+		void *locate_handle_buffer;
+		efi_status_t (*locate_protocol)(efi_guid_t *, void *, void **);
+		void *install_multiple_protocol_interfaces;
+		void *uninstall_multiple_protocol_interfaces;
+		void *calculate_crc32;
+		void *copy_mem;
+		void *set_mem;
+		void *create_event_ex;
+	};
+	efi_boot_services_32_t mixed_mode;
 } efi_boot_services_t;
 
 typedef enum {
@@ -401,11 +404,24 @@ typedef struct {
 	u64 write;
 } efi_pci_io_protocol_access_64_t;
 
+typedef union efi_pci_io_protocol efi_pci_io_protocol_t;
+
+typedef
+efi_status_t (*efi_pci_io_protocol_cfg_t)(efi_pci_io_protocol_t *,
+					  EFI_PCI_IO_PROTOCOL_WIDTH,
+					  u32 offset, unsigned long count,
+					  void *buffer);
+
 typedef struct {
 	void *read;
 	void *write;
 } efi_pci_io_protocol_access_t;
 
+typedef struct {
+	efi_pci_io_protocol_cfg_t read;
+	efi_pci_io_protocol_cfg_t write;
+} efi_pci_io_protocol_config_access_t;
+
 typedef struct {
 	u32 poll_mem;
 	u32 poll_io;
@@ -446,25 +462,46 @@ typedef struct {
 	u64 romimage;
 } efi_pci_io_protocol_64_t;
 
-typedef struct {
-	void *poll_mem;
-	void *poll_io;
-	efi_pci_io_protocol_access_t mem;
-	efi_pci_io_protocol_access_t io;
-	efi_pci_io_protocol_access_t pci;
-	void *copy_mem;
-	void *map;
-	void *unmap;
-	void *allocate_buffer;
-	void *free_buffer;
-	void *flush;
-	void *get_location;
-	void *attributes;
-	void *get_bar_attributes;
-	void *set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
-} efi_pci_io_protocol_t;
+union efi_pci_io_protocol {
+	struct {
+		void *poll_mem;
+		void *poll_io;
+		efi_pci_io_protocol_access_t mem;
+		efi_pci_io_protocol_access_t io;
+		efi_pci_io_protocol_config_access_t pci;
+		void *copy_mem;
+		void *map;
+		void *unmap;
+		void *allocate_buffer;
+		void *free_buffer;
+		void *flush;
+		void *get_location;
+		void *attributes;
+		void *get_bar_attributes;
+		void *set_bar_attributes;
+		uint64_t romsize;
+		void *romimage;
+	};
+	struct {
+		u32 poll_mem;
+		u32 poll_io;
+		efi_pci_io_protocol_access_32_t mem;
+		efi_pci_io_protocol_access_32_t io;
+		efi_pci_io_protocol_access_32_t pci;
+		u32 copy_mem;
+		u32 map;
+		u32 unmap;
+		u32 allocate_buffer;
+		u32 free_buffer;
+		u32 flush;
+		u32 get_location;
+		u32 attributes;
+		u32 get_bar_attributes;
+		u32 set_bar_attributes;
+		u64 romsize;
+		u32 romimage;
+	} mixed_mode;
+};
 
 #define EFI_PCI_IO_ATTRIBUTE_ISA_MOTHERBOARD_IO 0x0001
 #define EFI_PCI_IO_ATTRIBUTE_ISA_IO 0x0002
@@ -502,6 +539,33 @@ typedef struct {
 	u64 get_all;
 } apple_properties_protocol_64_t;
 
+struct efi_dev_path;
+
+typedef union apple_properties_protocol apple_properties_protocol_t;
+
+union apple_properties_protocol {
+	struct {
+		unsigned long version;
+		efi_status_t (*get)(apple_properties_protocol_t *,
+				    struct efi_dev_path *, efi_char16_t *,
+				    void *, u32 *);
+		efi_status_t (*set)(apple_properties_protocol_t *,
+				    struct efi_dev_path *, efi_char16_t *,
+				    void *, u32);
+		efi_status_t (*del)(apple_properties_protocol_t *,
+				    struct efi_dev_path *, efi_char16_t *);
+		efi_status_t (*get_all)(apple_properties_protocol_t *,
+					void *buffer, u32 *);
+	};
+	struct {
+		u32 version;
+		u32 get;
+		u32 set;
+		u32 del;
+		u32 get_all;
+	} mixed_mode;
+};
+
 typedef struct {
 	u32 get_capability;
 	u32 get_event_log;
@@ -524,16 +588,32 @@ typedef struct {
 
 typedef u32 efi_tcg2_event_log_format;
 
-typedef struct {
-	void *get_capability;
-	efi_status_t (*get_event_log)(efi_handle_t, efi_tcg2_event_log_format,
-		efi_physical_addr_t *, efi_physical_addr_t *, efi_bool_t *);
-	void *hash_log_extend_event;
-	void *submit_command;
-	void *get_active_pcr_banks;
-	void *set_active_pcr_banks;
-	void *get_result_of_set_active_pcr_banks;
-} efi_tcg2_protocol_t;
+typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
+
+union efi_tcg2_protocol {
+	struct {
+		void *get_capability;
+		efi_status_t (*get_event_log)(efi_handle_t,
+					      efi_tcg2_event_log_format,
+					      efi_physical_addr_t *,
+					      efi_physical_addr_t *,
+					      efi_bool_t *);
+		void *hash_log_extend_event;
+		void *submit_command;
+		void *get_active_pcr_banks;
+		void *set_active_pcr_banks;
+		void *get_result_of_set_active_pcr_banks;
+	};
+	struct {
+		u32 get_capability;
+		u32 get_event_log;
+		u32 hash_log_extend_event;
+		u32 submit_command;
+		u32 get_active_pcr_banks;
+		u32 set_active_pcr_banks;
+		u32 get_result_of_set_active_pcr_banks;
+	} mixed_mode;
+};
 
 /*
  * Types and defines for EFI ResetSystem
@@ -618,22 +698,25 @@ typedef efi_status_t efi_query_variable_store_t(u32 attributes,
 						unsigned long size,
 						bool nonblocking);
 
-typedef struct {
-	efi_table_hdr_t			hdr;
-	efi_get_time_t			*get_time;
-	efi_set_time_t			*set_time;
-	efi_get_wakeup_time_t		*get_wakeup_time;
-	efi_set_wakeup_time_t		*set_wakeup_time;
-	efi_set_virtual_address_map_t	*set_virtual_address_map;
-	void				*convert_pointer;
-	efi_get_variable_t		*get_variable;
-	efi_get_next_variable_t		*get_next_variable;
-	efi_set_variable_t		*set_variable;
-	efi_get_next_high_mono_count_t	*get_next_high_mono_count;
-	efi_reset_system_t		*reset_system;
-	efi_update_capsule_t		*update_capsule;
-	efi_query_capsule_caps_t	*query_capsule_caps;
-	efi_query_variable_info_t	*query_variable_info;
+typedef union {
+	struct {
+		efi_table_hdr_t			hdr;
+		efi_get_time_t			*get_time;
+		efi_set_time_t			*set_time;
+		efi_get_wakeup_time_t		*get_wakeup_time;
+		efi_set_wakeup_time_t		*set_wakeup_time;
+		efi_set_virtual_address_map_t	*set_virtual_address_map;
+		void				*convert_pointer;
+		efi_get_variable_t		*get_variable;
+		efi_get_next_variable_t		*get_next_variable;
+		efi_set_variable_t		*set_variable;
+		efi_get_next_high_mono_count_t	*get_next_high_mono_count;
+		efi_reset_system_t		*reset_system;
+		efi_update_capsule_t		*update_capsule;
+		efi_query_capsule_caps_t	*query_capsule_caps;
+		efi_query_variable_info_t	*query_variable_info;
+	};
+	efi_runtime_services_32_t mixed_mode;
 } efi_runtime_services_t;
 
 void efi_native_runtime_setup(void);
@@ -719,9 +802,12 @@ typedef struct {
 	u32 table;
 } efi_config_table_32_t;
 
-typedef struct {
-	efi_guid_t guid;
-	unsigned long table;
+typedef union {
+	struct {
+		efi_guid_t guid;
+		unsigned long table;
+	};
+	efi_config_table_32_t mixed_mode;
 } efi_config_table_t;
 
 typedef struct {
@@ -773,20 +859,23 @@ typedef struct {
 	u32 tables;
 } efi_system_table_32_t;
 
-typedef struct {
-	efi_table_hdr_t hdr;
-	unsigned long fw_vendor;	/* physical addr of CHAR16 vendor string */
-	u32 fw_revision;
-	unsigned long con_in_handle;
-	unsigned long con_in;
-	unsigned long con_out_handle;
-	unsigned long con_out;
-	unsigned long stderr_handle;
-	unsigned long stderr;
-	efi_runtime_services_t *runtime;
-	efi_boot_services_t *boottime;
-	unsigned long nr_tables;
-	unsigned long tables;
+typedef union {
+	struct {
+		efi_table_hdr_t hdr;
+		unsigned long fw_vendor;	/* physical addr of CHAR16 vendor string */
+		u32 fw_revision;
+		unsigned long con_in_handle;
+		unsigned long con_in;
+		unsigned long con_out_handle;
+		unsigned long con_out;
+		unsigned long stderr_handle;
+		unsigned long stderr;
+		efi_runtime_services_t *runtime;
+		efi_boot_services_t *boottime;
+		unsigned long nr_tables;
+		unsigned long tables;
+	};
+	efi_system_table_32_t mixed_mode;
 } efi_system_table_t;
 
 /*
@@ -856,22 +945,40 @@ typedef struct {
 	u64 unload;
 } efi_loaded_image_64_t;
 
-typedef struct {
-	u32 revision;
-	efi_handle_t parent_handle;
-	efi_system_table_t *system_table;
-	efi_handle_t device_handle;
-	void *file_path;
-	void *reserved;
-	u32 load_options_size;
-	void *load_options;
-	void *image_base;
-	__aligned_u64 image_size;
-	unsigned int image_code_type;
-	unsigned int image_data_type;
-	efi_status_t (*unload)(efi_handle_t image_handle);
-} efi_loaded_image_t;
+typedef union efi_loaded_image efi_loaded_image_t;
 
+union efi_loaded_image {
+	struct {
+		u32 revision;
+		efi_handle_t parent_handle;
+		efi_system_table_t *system_table;
+		efi_handle_t device_handle;
+		void *file_path;
+		void *reserved;
+		u32 load_options_size;
+		void *load_options;
+		void *image_base;
+		__aligned_u64 image_size;
+		unsigned int image_code_type;
+		unsigned int image_data_type;
+		efi_status_t (*unload)(efi_handle_t image_handle);
+	};
+	struct {
+		u32 revision;
+		u32 parent_handle;
+		u32 system_table;
+		u32 device_handle;
+		u32 file_path;
+		u32 reserved;
+		u32 load_options_size;
+		u32 load_options;
+		u32 image_base;
+		__aligned_u64 image_size;
+		unsigned int image_code_type;
+		unsigned int image_data_type;
+		u32 unload;
+	} mixed_mode;
+};
 
 typedef struct {
 	u64 size;
@@ -912,23 +1019,40 @@ typedef struct {
 	u64 flush;
 } efi_file_handle_64_t;
 
-typedef struct _efi_file_handle {
-	u64 revision;
-	efi_status_t (*open)(struct _efi_file_handle *,
-			     struct _efi_file_handle **,
-			     efi_char16_t *, u64, u64);
-	efi_status_t (*close)(struct _efi_file_handle *);
-	void *delete;
-	efi_status_t (*read)(struct _efi_file_handle *, unsigned long *,
-			     void *);
-	void *write;
-	void *get_position;
-	void *set_position;
-	efi_status_t (*get_info)(struct _efi_file_handle *, efi_guid_t *,
-			unsigned long *, void *);
-	void *set_info;
-	void *flush;
-} efi_file_handle_t;
+typedef union efi_file_handle efi_file_handle_t;
+
+union efi_file_handle {
+	struct {
+		u64 revision;
+		efi_status_t (*open)(efi_file_handle_t *,
+				     efi_file_handle_t **,
+				     efi_char16_t *, u64, u64);
+		efi_status_t (*close)(efi_file_handle_t *);
+		void *delete;
+		efi_status_t (*read)(efi_file_handle_t *, unsigned long *,
+				     void *);
+		void *write;
+		void *get_position;
+		void *set_position;
+		efi_status_t (*get_info)(efi_file_handle_t *, efi_guid_t *,
+				unsigned long *, void *);
+		void *set_info;
+		void *flush;
+	};
+	struct {
+		u64 revision;
+		u32 open;
+		u32 close;
+		u32 delete;
+		u32 read;
+		u32 write;
+		u32 get_position;
+		u32 set_position;
+		u32 get_info;
+		u32 set_info;
+		u32 flush;
+	} mixed_mode;
+};
 
 typedef struct {
 	u64 revision;
@@ -940,11 +1064,19 @@ typedef struct {
 	u64 open_volume;
 } efi_file_io_interface_64_t;
 
-typedef struct _efi_file_io_interface {
-	u64 revision;
-	int (*open_volume)(struct _efi_file_io_interface *,
-			   efi_file_handle_t **);
-} efi_file_io_interface_t;
+typedef union efi_file_io_interface efi_file_io_interface_t;
+
+union efi_file_io_interface {
+	struct {
+		u64 revision;
+		int (*open_volume)(efi_file_io_interface_t *,
+				   efi_file_handle_t **);
+	};
+	struct {
+		u64 revision;
+		u32 open_volume;
+	} mixed_mode;
+} ;
 
 #define EFI_FILE_MODE_READ	0x0000000000000001
 #define EFI_FILE_MODE_WRITE	0x0000000000000002
@@ -1416,10 +1548,20 @@ typedef struct {
 	u64 test_string;
 } efi_simple_text_output_protocol_64_t;
 
-struct efi_simple_text_output_protocol {
-	void *reset;
-	efi_status_t (*output_string)(void *, void *);
-	void *test_string;
+typedef union efi_simple_text_output_protocol efi_simple_text_output_protocol_t;
+
+union efi_simple_text_output_protocol {
+	struct {
+		void *reset;
+		efi_status_t (*output_string)(efi_simple_text_output_protocol_t *,
+					      efi_char16_t *);
+		void *test_string;
+	};
+	struct {
+		u32 reset;
+		u32 output_string;
+		u32 test_string;
+	} mixed_mode;
 };
 
 #define PIXEL_RGB_RESERVED_8BIT_PER_COLOR		0
@@ -1462,14 +1604,26 @@ typedef struct {
 	u64 frame_buffer_size;
 } efi_graphics_output_protocol_mode_64_t;
 
-typedef struct {
-	u32 max_mode;
-	u32 mode;
-	efi_graphics_output_mode_info_t *info;
-	unsigned long size_of_info;
-	efi_physical_addr_t frame_buffer_base;
-	unsigned long frame_buffer_size;
-} efi_graphics_output_protocol_mode_t;
+typedef union efi_graphics_output_protocol_mode efi_graphics_output_protocol_mode_t;
+
+union efi_graphics_output_protocol_mode {
+	struct {
+		u32 max_mode;
+		u32 mode;
+		efi_graphics_output_mode_info_t *info;
+		unsigned long size_of_info;
+		efi_physical_addr_t frame_buffer_base;
+		unsigned long frame_buffer_size;
+	};
+	struct {
+		u32 max_mode;
+		u32 mode;
+		u32 info;
+		u32 size_of_info;
+		u64 frame_buffer_base;
+		u32 frame_buffer_size;
+	} mixed_mode;
+};
 
 typedef struct {
 	u32 query_mode;
@@ -1485,12 +1639,22 @@ typedef struct {
 	u64 mode;
 } efi_graphics_output_protocol_64_t;
 
-typedef struct {
-	void *query_mode;
-	void *set_mode;
-	void *blt;
-	efi_graphics_output_protocol_mode_t *mode;
-} efi_graphics_output_protocol_t;
+typedef union efi_graphics_output_protocol efi_graphics_output_protocol_t;
+
+union efi_graphics_output_protocol {
+	struct {
+		void *query_mode;
+		void *set_mode;
+		void *blt;
+		efi_graphics_output_protocol_mode_t *mode;
+	};
+	struct {
+		u32 query_mode;
+		u32 set_mode;
+		u32 blt;
+		u32 mode;
+	} mixed_mode;
+};
 
 extern struct list_head efivar_sysfs_list;
 
-- 
2.20.1

